const AlimentoModel = require('../models/Alimentos.Model');
const moment = require('moment-timezone');
const { buildFileUri } = require('../config/s3');

const obtenerFavoritos = async (req, res) => {
  const { idUsuario } = req.body;
  try {
    const alimentos = await AlimentoModel.find({ usuario: idUsuario, favorito: true }).populate('ingredientes').lean().sort({ createdAt: -1 });

    // Construir los datos para la respuesta con los campos especificados
    const alimentosResponse = [];
    moment.locale('es'); // Establece el idioma a español

    for (const alimento of alimentos) {
      const alimentoData = {
        imageUrl: alimento.foto ? buildFileUri(alimento.foto) : null, // Obtener la URL de la imagen
        nombre: alimento.nombre,
        time: moment(alimento.createdAt)
          .tz('America/Mexico_City') // Establece la zona horaria de Ciudad de México
          .format('h:mm a') || '', // Formato de hora: 6:22 p.m.
        calorias: alimento?.calorias ? Math.round(alimento.calorias) : 0,
        proteina: alimento?.proteina ? Math.round(alimento.proteina) : 0,
        carbohidratos: alimento?.carbohidratos ? Math.round(alimento.carbohidratos) : 0,
        grasas: alimento?.grasas ? Math.round(alimento.grasas) : 0,
        _id: alimento?._id,
        favorito: !!alimento.favorito,
        porciones: alimento?.porciones || 0,
        puntuacionSalud: {
          nombre: alimento?.puntuacionSalud?.nombre || '',
          descripcion: alimento?.puntuacionSalud?.descripcion || '',
          score: alimento?.puntuacionSalud?.score || '',
          caracteristicas: alimento?.puntuacionSalud?.caracteristicas || []
        },
        ingredientes: alimento?.ingredientes?.map((ingrediente) => {
          return {
            ...ingrediente,
            calorias: ingrediente?.calorias ? Math.round(ingrediente.calorias) : 0,
            proteina: ingrediente?.proteina ? Math.round(ingrediente.proteina) : 0,
            carbohidratos: ingrediente?.carbohidratos ? Math.round(ingrediente.carbohidratos) : 0,
            grasas: ingrediente?.grasas ? Math.round(ingrediente.grasas) : 0
          };
        })
      };

      alimentosResponse.push(alimentoData);
    }

    return res.status(200).json({ alimentos: alimentosResponse });
  } catch (error) {
    console.error(error);
    return res.json(500).json({ message: 'Intenta más tarde' });
  }
};

const favoritoAlimento = async (req, res) => {
  console.log(req.body);
  const { idAlimento, fecha } = req.body;

  try {
    const alimento = await AlimentoModel.findById(idAlimento);

    const alimentoSave = await AlimentoModel.create({
      usuario: alimento.usuario,
      favorito: false,
      nombre: alimento.nombre,
      foto: alimento.foto,
      ingredientes: alimento.ingredientes,
      porciones: alimento.porciones,
      calorias: alimento.calorias,
      proteina: alimento.proteina,
      carbohidratos: alimento.carbohidratos,
      grasas: alimento.grasas,
      puntuacionSalud: alimento.puntuacionSalud,
      fecha
    });

    return res.status(200).json({ alimento: alimentoSave });
  } catch (error) {
    console.error(error);
    return res.json(500).json({ message: 'Intenta más tarde' });
  }
};
module.exports = {
  obtenerFavoritos,
  favoritoAlimento
};
