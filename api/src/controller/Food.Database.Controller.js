const AlimentosPSD = require('../models/Alimentos.psd.Model');
const AlimentoModel = require('../models/Alimentos.Model');

const createAlimento = async (req, res) => {
  const { idComida, idUsuario, fecha } = req.body;

  try {
    if (!idUsuario) {
      return res.status(400).json({ error: 'El campo de búsqueda es obligatorio.' });
    }

    const findAlimento = await AlimentosPSD.findById(idComida);

    const createAlimento = await AlimentoModel.create({
      usuario: idUsuario,
      favorito: false,
      nombre: findAlimento.nombre || '',
      foto: '',
      ingredientes: [],
      porciones: 1,
      calorias: findAlimento.calorias,
      proteina: findAlimento.proteina,
      carbohidratos: findAlimento.carbohidratos,
      grasas: findAlimento.grasas,
      puntuacionSalud: null,
      fecha
    });

    console.log(createAlimento);

    return res.status(200).json({ alimento: createAlimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Ocurrió un error en el servidor.' });
  }
};

const searchAlimento = async (req, res) => {
  const { search } = req.body;

  try {
    if (!search) {
      return res.status(400).json({ error: 'El campo de búsqueda es obligatorio.' });
    }

    // Normalizar el texto de búsqueda (quitar tildes, convertir a minúsculas)
    const normalizeText = (text) =>
      text
        .normalize('NFD') // Descompone caracteres con tildes
        .replace(/[\u0300-\u036f]/g, '') // Elimina marcas diacríticas
        .toLowerCase(); // Convierte a minúsculas

    const normalizedSearch = normalizeText(search);

    // Dividir la búsqueda en palabras
    const searchWords = normalizedSearch.split(/\s+/).filter(Boolean);

    // Crear condiciones para $and y $or
    const andConditions = searchWords.map((word) => ({
      nombre: { $regex: new RegExp(word, 'i') } // Todas las palabras deben coincidir
    }));

    const orConditions = searchWords.map((word) => ({
      nombre: { $regex: new RegExp(word, 'i') } // Al menos una palabra puede coincidir
    }));

    // Realizar la búsqueda combinando $and y $or
    const alimentos = await AlimentosPSD.find({
      $or: [
        { $and: andConditions }, // Coincide con todas las palabras
        { $or: orConditions } // Coincide con alguna palabra
      ]
    })
      .limit(50)
      .sort({ nombre: 1 }); // Ordenar por nombre

    return res.status(200).json(alimentos);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Ocurrió un error en el servidor.' });
  }
};

module.exports = {
  searchAlimento,
  createAlimento
};
