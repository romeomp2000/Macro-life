/* eslint-disable indent */
/* eslint-disable array-callback-return */
const { OPENAI_API_KEY, API_KEY_CODE_BAR } = require('../config/index');
// const { Types } = require('mongoose');
const { uploadFile } = require('../config/s3');
const AlimentoModel = require('../models/Alimentos.Model');
const IngredienteModel = require('../models/Ingredientes.Model');
const UsuarioModel = require('../models/Usuario.Model');
// const moment = require('moment');
const moment2 = require('moment-timezone');

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: OPENAI_API_KEY });
const axios = require('axios');
const ENDPOINT_CODE_BARRAS = 'https://api.barcodelokup.coom/v3';
const MODEL = 'gpt-4o-mini';

const prompt = `
    Describe esta comida basada en la imagen y proporciona una estimación general de los valores nutricionales.
    No pongas comentarios ya que se va JSON.parse lo que respondas. DEBE ER UN JSON VALIDO.
    En español siempre responde.
    Debe ser el mimo calorís, proteínas, grasas totales por los ingredientes y porciones.
    En algunas imagenes aparecen los macronutrientes escritos, si es el caso, por favor inclúyelos en el análisis.
    {
      "nombre": "Nombre del plato global",
      "calorias": Calorías totales,
      "proteina": Proteína total (g),
      "carbohidratos": Carbohidratos totales (g),
      "grasas": Grasas totales (g),
      "porciones": Debes analizar el alimento y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
      "puntuacion_salud": {
        "score": Calificación del 1 al 10 dependiendo si es saludable,
        "nombre": "Descripción breve según la calificación, por ejemplo, 'Algo saludable' si la calificación es 4",
        "descripcion": "Esta comida incluye aspectos que podrían no ser los mejores para la salud si se consume con frecuencia. Considere moderación...",
        "caracteristicas" ["Danos máximo 5 una caracterices ejemplo: Alto en proteínas (32g) que es beneficioso para la reparación muscular.", "Contenido moderado en grasas (21g)"]
      },
      "ingredientes": [
        {
          "nombre": "Nombre del ingrediente (e.g., platano, huevo)",
          "calorias": Calorías,
          "proteina": Proteína (g),
          "carbohidratos": Carbohidratos (g),
          "grasas": Grasas (g),
          "porciones": Debes analizar el ingrediente y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
        }
      ]
    }
  `;

const promptMacronutrientes = `
    Describe esta comida basada en el JSON proporcionado una estimación general de los valores nutricionales.
    No pongas comentarios ya que se va JSON.parse lo que respondas.
    En español siempre responde.
    Debe ser el mimo calorís, proteínas, grasas totales por los ingredientes y porciones.
    En algunas imagenes aparecen los macronutrientes escritos, si es el caso, por favor inclúyelos en el análisis.
    {
      "nombre": "Nombre del plato global",
      "calorias": Calorías totales,
      "proteina": Proteína total (g),
      "porciones": Debes analizar el alimento y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
      "carbohidratos": Carbohidratos totales (g),
      "grasas": Grasas totales (g),
      "puntuacion_salud": {
        "score": Calificación del 1 al 10 dependiendo si es saludable,
        "nombre": "Descripción breve según la calificación, por ejemplo, 'Algo saludable' si la calificación es 4",
        "descripcion": "Esta comida incluye aspectos que podrían no ser los mejores para la salud si se consume con frecuencia. Considere moderación...",
        "caracteristicas" ["Danos máximo 5 una caracterices ejemplo: Alto en proteínas (32g) que es beneficioso para la reparación muscular.", "Contenido moderado en grasas (21g)"],
      },
      "ingredientes": [
        {
          "nombre":"Nombre del ingrediente (e.g., hamburguesa, papas)",
          "calorias": Calorías,
          "proteina": Proteína (g),
          "carbohidratos": Carbohidratos (g),
          "grasas": Grasas (g),
          "porciones": Debes analizar el ingrediente y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
        }
      ]
    }
  `;

const promptTexto = (comida) => `
    El usuario dijo: ${comida}
    Describe esta comida basada en el JSON proporcionado una estimación general de los valores nutricionales.
    No pongas comentarios ya que se va JSON.parse lo que respondas.
    En español siempre responde.
    Debe ser el mimo calorís, proteínas, grasas totales por los ingredientes y porciones.
    {
      "nombre": "Nombre del plato global (e.g., hamburguesa, papas)",
      "calorias": Calorías totales,
      "proteina": Proteína total (g),
      "porciones": Debes analizar el alimento y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
      "carbohidratos": Carbohidratos totales (g),
      "grasas": Grasas totales (g),
      "puntuacion_salud": {
        "score": Calificación del 1 al 10 dependiendo si es saludable,
        "nombre": "Descripción breve según la calificación, por ejemplo, 'Algo saludable' si la calificación es 4",
        "descripcion": "Esta comida incluye aspectos que podrían no ser los mejores para la salud si se consume con frecuencia. Considere moderación...",
        "caracteristicas" ["Danos máximo 5 una caracterices ejemplo: Alto en proteínas (32g) que es beneficioso para la reparación muscular.", "Contenido moderado en grasas (21g)"],
      },
      "ingredientes": [
        {
          "nombre":"Nombre del ingrediente (e.g., hamburguesa, papas)",
          "calorias": Calorías,
          "proteina": Proteína (g),
          "carbohidratos": Carbohidratos (g),
          "grasas": Grasas (g),
          "porciones": Debes analizar el ingrediente y ver cuanta porsión es, ejemeplo 0.5, 1, 3, si vemos 3 huevos, o 3 llemas o 3 galleta
        }
      ]
    }
  `;

const analizarComida = async (req, res) => {
  const comida = req?.files?.comida || null;
  const { idUsuario, fecha, barcode = null } = req.body; // Agregamos "tipo" para determinar el flujo: "barcode" o "imagen"

  if (!comida) {
    return res.status(400).json({ message: 'La imagen de la comida es necesaria.' });
  }

  if (!idUsuario) {
    return res.status(400).json({ message: 'El usuario es necesario.' });
  }

  try {
    // Subimos la imagen a S3
    const comidaS3 = await uploadFile(comida, 'comida');

    rachaPuntosContador(idUsuario);
    if (barcode) {
      const url = `${ENDPOINT_CODE_BARRAS}/products?barcode=${barcode}&formatted=y&key=${API_KEY_CODE_BAR}`;
      const { data } = await axios.get(url);

      // Pasamos los datos a GPT para obtener valores nutrimentales
      const responseChatNutri = await openai.chat.completions.create({
        model: MODEL,
        messages: [
          {
            role: 'user',
            content: [
              { type: 'text', text: promptMacronutrientes + `${JSON.stringify(data)}` }
            ]
          }
        ]
      });

      const rawResponseNutrimentales = responseChatNutri.choices[0].message.content;
      const jsonResponseNutrimental = extractJson(rawResponseNutrimentales);

      return res.status(200).json({ jsonResponseNutrimental });
    } else {
      // Flujo para análisis directo de la imagen del alimento
      const response = await openai.chat.completions.create({
        model: MODEL,
        // temperature: 0.9, // Moderadamente creativo
        // top_p: 0.1, // Usa el núcleo de muestreo para más variedad
        // frequency_penalty: 0.5, // Penaliza repeticiones leves
        // presence_penalty: 0.3, // Fomenta ideas
        messages: [
          {
            role: 'user',
            content: [
              { type: 'text', text: prompt },
              {
                type: 'image_url',
                image_url: {
                  url: comidaS3.fileUrl,
                  detail: 'high'
                }
              }
            ]
          }
        ]
      });

      const rawResponse = response.choices[0].message.content;
      console.log(rawResponse);
      const jsonResponse = extractJson(rawResponse);

      const ingredientes = jsonResponse?.ingredientes?.map((ingrediente) => ({
        nombre: ingrediente?.nombre || '',
        calorias: ingrediente?.calorias || 0,
        proteina: ingrediente?.proteina || 0,
        carbohidratos: ingrediente?.carbohidratos || 0,
        grasas: ingrediente?.grasas || 0,
        usuario: idUsuario,
        porciones: ingrediente.porciones || 0
      })) || [];

      const ingredientesInsert = ingredientes.length > 0
        ? await IngredienteModel.insertMany(ingredientes)
        : [];

      const ingredienteIds = ingredientesInsert.map((ingrediente) => ingrediente._id);

      const puntuacionSalud = jsonResponse?.puntuacion_salud
        ? {
          nombre: jsonResponse?.puntuacion_salud?.nombre || '',
          descripcion: jsonResponse?.puntuacion_salud?.descripcion || '',
          score: jsonResponse?.puntuacion_salud?.score || 0,
          caracteristicas: jsonResponse?.puntuacion_salud?.caracteristicas || []
        }
        : null;

      const alimento = {
        usuario: idUsuario,
        nombre: jsonResponse?.nombre || '',
        foto: comidaS3.path,
        porciones: jsonResponse.porciones || 0,
        calorias: jsonResponse.calorias || 0,
        proteina: jsonResponse?.proteina || 0,
        carbohidratos: jsonResponse?.carbohidratos || 0,
        grasas: jsonResponse?.grasas || 0,
        puntuacionSalud,
        ingredientes: ingredienteIds,
        fecha
      };

      await AlimentoModel.create(alimento);

      const findUsuario = await UsuarioModel.findById(idUsuario);

      return res.status(200).json({ usuario: findUsuario });
    }
  } catch (error) {
    console.error('Error al procesar la solicitud:', error);
    return res.status(500).json({ message: 'Error interno al procesar la solicitud.' });
  }
};

const extractJson = (rawResponse) => {
  const jsonStartIndex = rawResponse.indexOf('{');
  const jsonEndIndex = rawResponse.lastIndexOf('}');
  if (jsonStartIndex === -1 || jsonEndIndex === -1) {
    throw new Error('No se pudo extraer el JSON de la respuesta.');
  }
  return JSON.parse(rawResponse.slice(jsonStartIndex, jsonEndIndex + 1));
};

const rachaPuntosContador = async (idUsuario) => {
  try {
    const fechaHoyMexico = moment2().tz('America/Mexico_City').format('YYYY-MM-DD');

    const findUsuario = await UsuarioModel.findById(idUsuario);
    if (!findUsuario) {
      return null;
    }

    if (findUsuario.ultimoAlimento === fechaHoyMexico) {
      return false;
    } else {
      findUsuario.rachaDias = findUsuario.rachaDias + 1;
      findUsuario.ultimoAlimento = fechaHoyMexico;
      await findUsuario.save();
      return true;
    }
  } catch (error) {
    console.log(error);
    return false;
  }
};

const analizarComidaTexto = async (req, res) => {
  const { usuario, comida, fecha, id } = req.body;
  try {
    rachaPuntosContador(usuario);

    const responseChatNutri = await openai.chat.completions.create({
      model: MODEL,
      messages: [
        {
          role: 'user',
          content: [
            { type: 'text', text: promptTexto(comida) }
          ]
        }
      ]
    });

    const rawResponse = responseChatNutri.choices[0].message.content;
    const jsonResponse = extractJson(rawResponse);

    const ingredientes = jsonResponse?.ingredientes?.map((ingrediente) => ({
      nombre: ingrediente?.nombre || '',
      calorias: ingrediente?.calorias || 0,
      proteina: ingrediente?.proteina || 0,
      carbohidratos: ingrediente?.carbohidratos || 0,
      grasas: ingrediente?.grasas || 0,
      usuario,
      porciones: ingrediente.porciones || 0
    })) || [];

    const ingredientesInsert = ingredientes.length > 0
      ? await IngredienteModel.insertMany(ingredientes)
      : [];

    const ingredienteIds = ingredientesInsert.map((ingrediente) => ingrediente._id);

    const puntuacionSalud = jsonResponse?.puntuacion_salud
      ? {
        nombre: jsonResponse?.puntuacion_salud?.nombre || '',
        descripcion: jsonResponse?.puntuacion_salud?.descripcion || '',
        score: jsonResponse?.puntuacion_salud?.score || 0,
        caracteristicas: jsonResponse?.puntuacion_salud?.caracteristicas || []
      }
      : null;

    const alimento = {
      usuario,
      nombre: jsonResponse?.nombre || '',
      porciones: jsonResponse.porciones || 0,
      calorias: jsonResponse.calorias || 0,
      proteina: jsonResponse?.proteina || 0,
      carbohidratos: jsonResponse?.carbohidratos || 0,
      grasas: jsonResponse?.grasas || 0,
      puntuacionSalud,
      ingredientes: ingredienteIds,
      fecha
    };

    if (id) {
      await AlimentoModel.findByIdAndUpdate(id, alimento);
    } else {
      await AlimentoModel.create(alimento);
    }

    // const findUsuario = await UsuarioModel.findById(usuario);

    return res.status(200).json({ message: 'Comida analizada' });
  } catch (error) {
    console.error('Error al procesar la solicitud:', error);
    return res.status(500).json({ message: 'Error interno al procesar la solicitud.' });
  }
};

module.exports = {
  analizarComida,
  analizarComidaTexto
};
