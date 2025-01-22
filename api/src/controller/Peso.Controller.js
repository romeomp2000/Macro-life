const UsuarioModel = require('../models/Usuario.Model');
const PesoHistorialModel = require('../models/PesoHistorial.Model');
const moment = require('moment-timezone');
const actualizarPesoObjetivo = async (req, res) => {
  const { pesoObjetivo, idUsuario } = req.body;

  try {
    const usuarioActualizado = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { pesoObjetivo },
      { new: true, runValidators: true } // Opciones: new para devolver el documento actualizado, runValidators para validar los datos
    );

    if (!usuarioActualizado) {
      return { mensaje: 'Usuario no encontrado' };
    }

    return res.status(200).json({ mensaje: 'Peso objetivo actualizado con éxito' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Error al actualizar' });
  }
};

const actualizarPesoActual = async (req, res) => {
  const { pesoActual, idUsuario } = req.body;

  try {
    const usuarioActualizado = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { pesoActual },
      { new: true, runValidators: true } // Opciones: new para devolver el documento actualizado, runValidators para validar los datos
    );

    if (!usuarioActualizado) {
      return { mensaje: 'Usuario no encontrado' };
    }
    // fecha mexico
    const fecha = moment().tz('America/Mexico_City');
    // Guardar el peso actual en el historial
    const nuevoPesoHistorial = new PesoHistorialModel({
      usuario: idUsuario,
      peso: pesoActual,
      fecha
    });

    nuevoPesoHistorial.save();

    return res.status(200).json({ mensaje: 'Peso actual actualizado con éxito' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Error al actualizar' });
  }
};

module.exports = { actualizarPesoObjetivo, actualizarPesoActual };
