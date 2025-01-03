const EjercicioModel = require('../models/Ejercicio.Model');
const UsuarioModel = require('../models/Usuario.Model');
const moment = require('moment-timezone');
const { Types } = require('mongoose');
const { OPENAI_API_KEY } = require('../config/index');
const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

const createEjercicio = async (req, res) => {
  const { tiempo, usuario, nombre, intensidad, ejercicio, id } = req.body;
  try {
    const findUsuario = await UsuarioModel.findById(usuario);

    if (!findUsuario) {
      return res.status().json({ message: 'usuario no existe' });
    }

    const peso = findUsuario.pesoActual;

    let met = 0;

    if (intensidad === 'Intenso') {
      met = 23;
    } else if (intensidad === 'Moderado') {
      met = 8.0;
    } else if (intensidad === 'Ligero') {
      met = 3.3;
    }

    const caloriasQuemadas = calcularCalorias(met, peso, tiempo);

    if (id) {
      const findEjercicio = await EjercicioModel.findByIdAndUpdate(id, {
        nombre,
        intensidad,
        calorias: caloriasQuemadas,
        tiempo,
        ejercicio
      }, { new: true });

      return res.status(200).json({ ejercicio: findEjercicio });
    } else {
      const nuevoEjercicio = await EjercicioModel.create({
        usuario,
        nombre,
        intensidad,
        calorias: caloriasQuemadas,
        tiempo,
        ejercicio
      });

      return res.status(200).json({ ejercicio: nuevoEjercicio });
    }
  } catch (error) {
    console.log(error);
    return res.json(500).json({ error });
  }
};

const createEjercicioPesas = async (req, res) => {
  const { tiempo, usuario, nombre, intensidad, ejercicio, id } = req.body;
  try {
    const findUsuario = await UsuarioModel.findById(usuario);

    if (!findUsuario) {
      return res.status().json({ message: 'usuario no existe' });
    }

    const peso = findUsuario.pesoActual;

    let met = 0;

    if (intensidad === 'Intenso') {
      met = 8;
    } else if (intensidad === 'Moderado') {
      met = 6.0;
    } else if (intensidad === 'Ligero') {
      met = 3;
    }

    const caloriasQuemadas = calcularCalorias(met, peso, tiempo);

    if (id) {
      const findEjercicio = await EjercicioModel.findByIdAndUpdate(id, {
        nombre,
        intensidad,
        calorias: caloriasQuemadas,
        tiempo,
        ejercicio
      }, { new: true });

      return res.status(200).json({ ejercicio: findEjercicio });
    } else {
      const nuevoEjercicio = await EjercicioModel.create({
        usuario,
        nombre,
        intensidad,
        calorias: caloriasQuemadas,
        tiempo,
        ejercicio
      });

      return res.status(200).json({ ejercicio: nuevoEjercicio });
    }
  } catch (error) {
    console.log(error);
    return res.json(500).json({ error });
  }
};

const describirEjercicioIA = async (req, res) => {
  const { descripcion, usuario, id } = req.body;
  try {
    const prompt = `Del ejercicio redactado necesito que me devuelvs un objeto de la siguiente manera sin importar del ejercicio:
    
    {
      "nombre": "Nombre del ejercicio",
      "intensidad": "Solo hay 3 ('Ligero', 'Moderado', 'Intenso') escoge la más cercana",
      "calorias": calorias quemadas en entero,
      "tiempo": tiempo del ejercicio en min,
    }
    
    Este es la descripción del texto:
    ${descripcion}
    `;

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

    const rawResponse = response.choices[0].message.content;
    const jsonResponse = extractJson(rawResponse);

    if (id) {
      const findEjercicio = await EjercicioModel.findByIdAndUpdate(id, {
        nombre: jsonResponse?.nombre || '',
        intensidad: jsonResponse?.intensidad || '',
        calorias: jsonResponse?.calorias,
        tiempo: jsonResponse?.tiempo,
        descripcion
      }, { new: true });
      return res.status(200).json({ ejercicio: findEjercicio });
    } else {
      const nuevoEjercicio = await EjercicioModel.create({
        usuario,
        nombre: jsonResponse?.nombre || '',
        intensidad: jsonResponse?.intensidad || '',
        calorias: jsonResponse?.calorias,
        tiempo: jsonResponse?.tiempo,
        ejercicio: 'Describir',
        descripcion
      });
      return res.status(200).json({ ejercicio: nuevoEjercicio });
    }
  } catch (error) {
    console.log(error);
    return res.json(500).json({ error });
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

const obtenerEjercicio = async (req, res) => {
  const { fecha, idUsuario } = req.body;
  const fechaHoy = moment.tz(fecha, 'YYYY-MM-DD', 'America/Mexico_City');

  try {
    // Obtener el inicio y fin del día
    const todayStart = fechaHoy.startOf('day').toDate();
    const todayEnd = fechaHoy.endOf('day').toDate();

    // Crear el filtro de consulta para el historial del usuario
    const query = {
      usuario: new Types.ObjectId(idUsuario),
      fecha: {
        $gte: moment(todayStart),
        $lte: moment(todayEnd)
      }

    };
    const ejercicios = await EjercicioModel.find(query).sort({ createdAt: -1 });

    let caloriasQuemadas = 0;
    let pasos = 0;
    let levantamientoPesass = 0;
    let otro = 0;

    ejercicios.forEach((e) => {
      caloriasQuemadas = caloriasQuemadas + e.calorias;

      if (e.ejercicio === 'Ejecutar') {
        pasos = pasos + e.calorias;
      }

      if (e.ejercicio === 'Levantamiento de pesas') {
        levantamientoPesass = levantamientoPesass + e.calorias;
      }

      if (e.ejercicio === 'Describir') {
        otro = otro + e.calorias;
      }
    });

    caloriasQuemadas = Math.floor(caloriasQuemadas);
    levantamientoPesass = Math.floor(levantamientoPesass);
    pasos = Math.floor(pasos);
    otro = Math.floor(otro);

    return res.status(200).json({ ejercicios, caloriasQuemadas, levantamientoPesass, pasos, otro });
  } catch (error) {
    return res.status(500).json({ error });
  }
};

const calcularCalorias = (met, peso, tiempo) => {
  const tiempoHoras = tiempo / 60; // Convertir minutos a horas
  const caloriasQuemadas = met * peso * tiempoHoras;
  return caloriasQuemadas;
};

module.exports = {
  createEjercicio,
  obtenerEjercicio,
  createEjercicioPesas,
  describirEjercicioIA
};
