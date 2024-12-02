const UsuarioModel = require('../models/Usuario.Model');

const EditarMacronutrientesDiario = async (req, res) => {
  const { calorias, carbohidratos, proteina, grasas, idUsuario } = req.body;

  try {
    console.log(req.body);
    // Actualizar los macronutrientes diarios usando findByIdAndUpdate
    const usuarioActualizado = await UsuarioModel.findByIdAndUpdate(
      idUsuario, // ID del usuario
      {
        $set: {
          'macronutrientesDiario.calorias': calorias,
          'macronutrientesDiario.carbohidratos': carbohidratos,
          'macronutrientesDiario.proteina': proteina,
          'macronutrientesDiario.grasas': grasas
        }
      },
      { new: true } // Esto hace que el método retorne el documento actualizado
    );

    if (!usuarioActualizado) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    // Regresar el usuario actualizado
    return res.status(200).json({ message: 'Macronutrientes actualizados', usuario: usuarioActualizado });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'Ocurrió un error, inténtelo más tarde', error });
  }
};

module.exports = {
  EditarMacronutrientesDiario
};
