const UsuarioModel = require('../models/Usuario.Model');
const { OPENAI_API_KEY } = require('../config/index');
const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: OPENAI_API_KEY });
const moment = require('moment-timezone');
const PesoHistorialModel = require('../models/PesoHistorial.Model');

const registroController = async (req, res) => {
  const {
    genero,
    entrenamiento,
    aplicacionSimilar,
    altura,
    peso,
    fechaNacimiento,
    objetivo,
    pesoDeseado,
    dieta,
    lograr,
    metaVelocidad,
    // metaImpedimento,
    referidoCodigo,
    appleID,
    googleId,
    correo,
    telefono,
    nombre,
    alarmaDesayuno,
    alarmaComida,
    alarmaCena
  } = req.body;

  try {
    if (!genero && !['Masculino', 'Femenino', 'Otro'].includes(genero)) {
      return res.status(400).json({ message: 'El genero es requerido.' });
    }

    if (!altura) {
      return res.status(400).json({ message: 'La altura es requerido.' });
    }

    if (!peso) {
      return res.status(400).json({ message: 'El peso es requerido.' });
    }
    if (!entrenamiento && !['0-2', '3-5', '6+'].includes(entrenamiento)) {
      return res.status(400).json({ message: 'El entrenamiento es requerido.' });
    }

    if (!fechaNacimiento) {
      return res.status(400).json({ message: 'La fecha de nacimiento es requerido.' });
    }

    if (!objetivo && !['Perder peso', 'Mantener', 'Aumentar peso'].includes(objetivo)) {
      return res.status(400).json({ message: 'El objetivo  es requerido.' });
    }

    if (!pesoDeseado) {
      return res.status(400).json({ message: 'El peso deseado es requerido.' });
    }

    if (!dieta) {
      return res.status(400).json({ message: 'La dieta es requerido.' });
    }

    if (!metaVelocidad) {
      return res.status(400).json({ message: 'La meta de velocidad es requerido.' });
    }

    // if (!metaImpedimento) {
    //   return res.status(400).json({ message: 'El impedimento  es requerido.' });
    // }

    const fechaNacimientoConZonaHoraria = moment.tz(fechaNacimiento, 'YYYY-MM-DD', 'America/Mexico_City');

    // Convierte esa fecha a UTC
    const fechaUTC = fechaNacimientoConZonaHoraria.utc();

    const findReferidoPadre = referidoCodigo ? await UsuarioModel.findOne({ codigo: referidoCodigo }) || null : null;

    const prompt = `
      Actúa como un experto en nutrición y entrenamiento físico. Basándote en la siguiente información, calcula los macronutrientes necesarios (calorías, proteínas, carbohidratos, grasas) y otorga una puntuación de salud (del 0 al 10). Considera las metas del usuario, la dieta y el estilo de vida.
      Teniendo en cuenta que estamos a ${moment()}
      Quiero que seas muy especifico con el tiempo entre la velocidad del objetivo dependiendo del día actual dependiendo del peos deeado que quiere llegar
      Información del usuario:
      - Género: ${genero}
      - Días de entrenamiento por semana: ${entrenamiento}
      - Altura: ${altura} cm
      - Peso actual: ${peso} kg
      - Fecha de nacimiento: ${fechaUTC.toString()}
      - Objetivo: ${objetivo}
      - Peso deseado: ${pesoDeseado} kg tenerlo muy en cuenta
      - Dieta específica: ${dieta || 'Ninguna'}
      - Qué le gustaría lograr: ${lograr?.split(',') || ''}
      - Velocidad para alcanzar la meta: ${metaVelocidad} el min es 0.1 y el max 1.5 si no hay es que quiere manter el peso

      Solo devuelve un objeto JSON con la siguiente estructura, no devuelvas otra cosa:
      {
        "macronutrientes": {
          "calorias": <valor en kcal>,
          "proteina": <valor en gramos>,
          "carbohidratos": <valor en gramos>,
          "grasas": <valor en gramos>
        },
        "puntuacionSalud": <valor del 0 al 10>,
        "fechaMeta": "fecha de posible objetivo completar"
      }
    `;

    console.log(prompt);

    const response = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        {
          role: 'user',
          content: [
            { type: 'text', text: prompt }
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

    const macronutrientesDiario = {
      calorias: jsonResponse?.macronutrientes?.calorias || 0,
      proteina: jsonResponse?.macronutrientes?.proteina || 0,
      carbohidratos: jsonResponse?.macronutrientes?.carbohidratos || 0,
      grasas: jsonResponse?.macronutrientes?.grasas || 0
    };

    const objUsuario = {
      referenciaUsuario: findReferidoPadre,
      fechaNacimiento: fechaUTC,
      altura,
      pesoActual: peso,
      genero,
      puntuacionSalud: jsonResponse?.puntuacionSalud || 0,
      macronutrientesDiario,
      entrenamientoSemanal: entrenamiento,
      aplicacionSimilar,
      objetivo,
      pesoObjetivo: pesoDeseado,
      dieta,
      lograr: lograr?.split(','),
      metaAlcanzar: metaVelocidad,
      // impideAlcanzar: metaImpedimento,
      fechaMeta: jsonResponse?.fechaMeta || null,
      appleID,
      googleId,
      correo,
      telefono,
      nombre,
      notificacionesAlarma: {
        desayuno: alarmaDesayuno,
        comida: alarmaComida,
        cenas: alarmaCena
      }

    };

    const newUsuario = await UsuarioModel.create(objUsuario);

    const findUsuario = await UsuarioModel.findById(newUsuario._id);

    const fecha = moment().tz('America/Mexico_City');
    // Guardar el peso actual en el historial
    const nuevoPesoHistorial = new PesoHistorialModel({
      usuario: newUsuario._id,
      peso,
      fecha
    });

    nuevoPesoHistorial.save();

    return res.status(200).json({ usuario: findUsuario, message: 'Se ha creado el usuario correctamente.' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: 'No se pudo registrar el usuario.', error });
  }
};

module.exports = {
  registroController
};
