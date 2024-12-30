const UsuarioModel = require('../models/Usuario.Model');

const buscaUsuario = async (req, res) => {
  const { id } = req.params;
  try {
    console.log(req.body);

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

const buscaAuth = async (req, res) => {
  const { googleId, appleID } = req.body;
  try {
    console.log(req.body);
    if (googleId) {
      const usuario = await UsuarioModel.findOne({ googleId });

      if (!usuario) {
        return res.status(400).json({ message: 'El usuario no existe.' });
      }

      return res.status(200).json({ usuario });
    } else if (appleID) {
      const usuario = await UsuarioModel.findOne({ appleID });

      if (!usuario) {
        return res.status(400).json({ message: 'El usuario no existe.' });
      }
      return res.status(200).json({ usuario });
    }

    return res.status(400).json({ message: 'El usuario no existe.' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

module.exports = {
  buscaUsuario,
  buscaAuth
};
