const ConfiguracionesModel = require('../models/Configuraciones.Model');

const obtenerConfiguraciones = async (req, res) => {
  try {
    const configuraciones = await ConfiguracionesModel.findOne();
    return res.status(200).json(configuraciones);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'Error interno al procesar la solicitud.' });
  }
};

module.exports = { obtenerConfiguraciones };
