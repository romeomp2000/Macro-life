/* eslint-disable array-callback-return */
const { OPENAI_API_KEY } = require('../config/index');
const { Types } = require('mongoose');
const { uploadFile } = require('../config/s3');
const AlimentoModel = require('../models/Alimentos.Model');
const IngredienteModel = require('../models/Ingredientes.Model');
const UsuarioModel = require('../models/Usuario.Model');
const mongoose = require('mongoose');
const moment = require('moment'); // Usamos moment para manejar fechas
const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

const analizarComida = async (req, res) => {
  const comida = req?.files?.comida || null;
  const { idUsuario, fecha } = req.body;

  console.log(req.body);

  if (comida == null) {
    return res.status(400).json({ message: 'La imagen de la comida es necesaria.' });
  }

  if (!idUsuario) {
    return res.status(400).json({ message: 'El usuarios es necesario.' });
  }

  // Subir la imagen a S3 y obtener la URL
  const prompt = `
    Describe esta comida basada en la imagen y proporciona una estimación general de los valores nutricionales.
    {
      "nombre": "Nombre del plato global",
      "calorias": Calorías totales,
      "proteina": Proteína total (g),
      "carbohidratos": Carbohidratos totales (g),
      "grasas": Grasas totales (g),
      "puntuacion_salud": {
        "score": Calificación del 1 al 10 dependiendo si es saludable,
        "nombre": "Descripción breve según la calificación, por ejemplo, 'Algo saludable' si la calificación es 4",
        "descripcion": "Esta comida incluye aspectos que podrían no ser los mejores para la salud si se consume con frecuencia. Considere moderación..."
      },
      "ingredientes": [
        {
          "nombre": "Nombre del ingrediente (e.g., hamburguesa, papas)",
          "calorias": Calorías,
          "proteina": Proteína (g),
          "carbohidratos": Carbohidratos (g),
          "grasas": Grasas (g)
        }
      ]
    }
  `;

  try {
    const rachaDias = await rachaPuntosContador(idUsuario);

    const comidaS3 = await uploadFile(comida, 'comida');

    const response = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        {
          role: 'user',
          content: [
            { type: 'text', text: prompt },
            {
              type: 'image_url',
              image_url: {
                url: comidaS3.fileUrl,
                detail: 'low'
              }
            }
          ]
        }
      ]

    });

    // Obtenemos el contenido generado por el modelo
    const rawResponse = response.choices[0].message.content;

    // Extraemos la parte que corresponde al JSON
    const jsonStartIndex = rawResponse.indexOf('{');
    const jsonEndIndex = rawResponse.lastIndexOf('}');

    if (jsonStartIndex === -1 || jsonEndIndex === -1) {
      return res.status(500).send('No se pudo procesar la imagen correctamente.');
    }

    const jsonString = rawResponse.slice(jsonStartIndex, jsonEndIndex + 1);

    // Parseamos el JSON
    const jsonResponse = JSON.parse(jsonString);

    const ingredientes = jsonResponse?.ingredientes?.map((ingrediente) => {
      return {
        nombre: ingrediente?.nombre || '',
        calorias: ingrediente?.ingrediente || 0,
        proteina: ingrediente?.proteina || 0,
        carbohidratos: ingrediente?.carbohidratos || 0,
        grasas: ingrediente?.grasas || 0,
        usuario: idUsuario
      };
    }) || [];

    const ingredientesInsert = ingredientes?.length > 0
      ? await IngredienteModel.insertMany(ingredientes)
      : [];

    const ingredienteIds = ingredientesInsert.map(ingrediente => ingrediente._id);

    const puntuacionSalud = {
      nombre: jsonResponse?.puntuacion_salud?.nombre || '',
      descripcion: jsonResponse?.puntuacion_salud?.descripcion || '',
      score: jsonResponse?.puntuacion_salud?.score || 0
    };

    const alimento = {
      usuario: idUsuario,
      nombre: jsonResponse?.nombre || '',
      foto: comidaS3.path,
      porciones: 1,
      calorias: jsonResponse.calorias || 0,
      proteina: jsonResponse?.proteina || 0,
      carbohidratos: jsonResponse?.carbohidratos || 0,
      grasas: jsonResponse?.grasas || 0,
      puntuacionSalud,
      ingredientes: ingredienteIds,
      fecha
    };

    const alimentoInsert = await AlimentoModel.create(alimento);

    const findUsuario = await UsuarioModel.findById(idUsuario);

    const calorias = await getNutrientesPorUsuario(idUsuario, fecha);
    console.log(calorias);

    return res.status(200).json({ alimento: alimentoInsert, rachaDias, usuario: findUsuario, calorias });
  } catch (error) {
    console.error('Error al procesar la solicitud:', error);
    res.status(500).json({ error });
  }
};

const rachaPuntosContador = async (idUsuario) => {
  try {
    let rachaDias = 0;
    const todayStart = moment().startOf('day').toDate();

    // Obtén la fecha de fin de hoy (23:59:59)
    const todayEnd = moment().endOf('day').toDate();

    const query = {
      usuario: new Types.ObjectId(idUsuario),
      createdAt: {
        $gte: moment(todayStart),
        $lte: moment(todayEnd)
      }
    };

    const findAlimentosDiario = await AlimentoModel.countDocuments(query);

    if (findAlimentosDiario === 0) {
      // Actualiza el campo 'rachaDias' sumando 1
      const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
        idUsuario, // El ID del usuario que quieres actualizar
        { $inc: { rachaDias: 1 } }, // Incrementa 'rachaDias' en 1
        { new: true } // Devuelve el documento actualizado
      );

      rachaDias = updatedUsuario.rachaDias;

      return rachaDias;
    } else {
      console.log('ya se había registrado');
      return null;
    }
  } catch (error) {
    console.log(error);
    return null;
  }
};

const getNutrientesPorUsuario = async (usuarioId, fechaString) => {
  // Convertimos la fecha proporcionada al inicio del día en la zona horaria de México
  const fechaBase = new Date(fechaString); // Ejemplo: "2024-11-29T00:00:00.000Z"

  // Ajustamos la fecha al huso horario UTC-6
  const offsetMexico = -6 * 60 * 60 * 1000; // UTC-6 en milisegundos
  const inicioDia = new Date(fechaBase.getTime() + offsetMexico); // Inicio del día en UTC
  const finDia = new Date(inicioDia.getTime() + 24 * 60 * 60 * 1000 - 1); // Fin del día en UTC

  try {
    // Obtenemos los resultados de la consulta agregada de los alimentos consumidos
    const resultados = await AlimentoModel.aggregate([
      {
        $match: {
          usuario: new mongoose.Types.ObjectId(usuarioId), // Corregido: usa 'new'
          createdAt: { $gte: inicioDia, $lte: finDia } // Filtra por rango de fechas en UTC ajustado
        }
      },
      {
        $project: {
          caloriasTotales: { $multiply: ['$calorias', '$porciones'] },
          proteinaTotal: { $multiply: ['$proteina', '$porciones'] },
          carbohidratosTotales: { $multiply: ['$carbohidratos', '$porciones'] },
          grasasTotales: { $multiply: ['$grasas', '$porciones'] }
        }
      },
      {
        $group: {
          _id: null, // Agrupamos todo en un solo resultado
          totalCalorias: { $sum: '$caloriasTotales' },
          totalProteina: { $sum: '$proteinaTotal' },
          totalCarbohidratos: { $sum: '$carbohidratosTotales' },
          totalGrasas: { $sum: '$grasasTotales' }
        }
      }
    ]);

    // Buscamos al usuario para obtener sus carbohidratos diarios
    const usuario = await UsuarioModel.findById(usuarioId);

    // Verificamos si existen los resultados y si el usuario tiene los carbohidratos diarios establecidos
    if (resultados.length && usuario && usuario.macronutrientesDiario.carbohidratos) {
      const carbohidratosConsumidos = resultados[0].totalCarbohidratos;
      const carbohidratosDiarios = usuario.macronutrientesDiario.carbohidratos;

      // Ajustamos los carbohidratos según el límite diario
      let carbohidratosAjustados = carbohidratosConsumidos;
      if (carbohidratosConsumidos > carbohidratosDiarios) {
        // Si se pasa del límite, sumamos el excedente
        carbohidratosAjustados = carbohidratosConsumidos - carbohidratosDiarios;
      } else {
        // Si no se pasa, restamos el déficit
        carbohidratosAjustados = carbohidratosDiarios - carbohidratosConsumidos;
      }

      // Se devuelve el resultado con los carbohidratos ajustados
      return {
        ...resultados[0],
        carbohidratosAjustados,
        diasAVencer: usuario.diasAVencer // Si también necesitas el conteo de días de vencimiento
      };
    }

    // Si no se encuentra el usuario o los datos no son adecuados, se retorna null
    return null;
  } catch (error) {
    console.error('Error en getNutrientesPorUsuario:', error);
    throw new Error('Error al procesar la consulta.');
  }
};

module.exports = {
  analizarComida

};
