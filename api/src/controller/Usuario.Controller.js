const UsuarioModel = require('../models/Usuario.Model');

const buscaUsuario = async (req, res) => {
  const { id } = req.params;
  try {
    const usuario = await UsuarioModel.findById(id);

    if (!usuario) {
      return res.status(400).json({ message: 'El usuario no existe.' });
    }

    return res.status(200).json({ usuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

module.exports = {
  buscaUsuario
};
