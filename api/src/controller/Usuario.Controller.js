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

const actualizarNombre = async (req, res) => {
  const { idUsuario, nombre } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { nombre },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarTelefono = async (req, res) => {
  const { idUsuario, telefono } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { telefono },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarCorreo = async (req, res) => {
  const { idUsuario, correo } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { correo },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarPeso = async (req, res) => {
  const { idUsuario, peso } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { peso },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarAltura = async (req, res) => {
  const { idUsuario, altura } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { altura },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarFechaNacimiento = async (req, res) => {
  const { idUsuario, fechaNacimiento } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { fechaNacimiento },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarGenero = async (req, res) => {
  const { idUsuario, genero } = req.body;

  try {
    const updatedUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { genero },
      { new: true }
    );

    return res.status(200).json({ usuario: updatedUsuario });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

module.exports = {
  buscaUsuario,
  buscaAuth,
  actualizarNombre,
  actualizarTelefono,
  actualizarCorreo,
  actualizarAltura,
  actualizarPeso,
  actualizarFechaNacimiento,
  actualizarGenero
};
