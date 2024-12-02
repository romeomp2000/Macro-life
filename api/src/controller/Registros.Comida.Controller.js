const AlimentoModel = require('../models/Alimentos.Model');
const moment = require('moment-timezone');
const { Types } = require('mongoose');
const { buildFileUri } = require('../config/s3');

const obtenerHistorialUsuario = async (req, res) => {
  const { idUsuario, fecha } = req.body;

  try {
    // Convertir la fecha a la zona horaria de 'America/Mexico_City'
    const fechaHoy = moment.tz(fecha, 'YYYY-MM-DD', 'America/Mexico_City');

    // Obtener el inicio y fin del día
    const todayStart = fechaHoy.startOf('day').toDate();
    const todayEnd = fechaHoy.endOf('day').toDate();

    // Crear el filtro de consulta para el historial del usuario
    const query = {
      usuario: new Types.ObjectId(idUsuario),
      createdAt: {
        $gte: moment(todayStart),
        $lte: moment(todayEnd)
      }
    };

    // Realizar la búsqueda en la base de datos
    const alimentos = await AlimentoModel.find(query).populate('ingredientes').sort({ createdAt: -1 }); // Ordenar de manera descendente por createdAt

    // Construir los datos para la respuesta con los campos especificados
    const alimentosResponse = [];
    moment.locale('es'); // Establece el idioma a español

    for (const alimento of alimentos) {
      const alimentoData = {
        imageUrl: alimento.foto ? buildFileUri(alimento.foto) : null, // Obtener la URL de la imagen
        name: alimento.nombre,
        time: moment(alimento.createdAt)
          .tz('America/Mexico_City') // Establece la zona horaria de Ciudad de México
          .format('h:mm a') || '', // Formato de hora: 6:22 p.m.
        calories: alimento.calorias,
        protein: alimento.proteina,
        carbs: alimento.carbohidratos,
        fats: alimento.grasas,
        _id: alimento._id,
        ingredientes: alimento.ingredientes
      };

      alimentosResponse.push(alimentoData);
    }

    // Devolver los alimentos con los campos solicitados
    return res.status(200).json({ alimentos: alimentosResponse });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

module.exports = { obtenerHistorialUsuario };
