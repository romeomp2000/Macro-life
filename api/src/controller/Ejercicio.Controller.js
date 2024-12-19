const EjercicioModel = require('../models/Ejercicio.Model');
const UsuarioModel = require('../models/Usuario.Model');
const moment = require('moment-timezone');
const { Types } = require('mongoose');

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
    console.log(query);
    const ejercicios = await EjercicioModel.find(query).sort({ createdAt: -1 });

    return res.status(200).json({ ejercicios });
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
  obtenerEjercicio
};
