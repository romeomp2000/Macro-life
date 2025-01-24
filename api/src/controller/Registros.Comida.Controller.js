const AlimentoModel = require('../models/Alimentos.Model');
const ReporteComidaModel = require('../models/Reportar.Comida.Model');
const moment = require('moment-timezone');
const { Types } = require('mongoose');
const { buildFileUri } = require('../config/s3');
const mongoose = require('mongoose');
const IngredienteModel = require('../models/Ingredientes.Model');
const EjercicioModel = require('../models/Ejercicio.Model');

const obtenerHistorialUsuario = async (req, res) => {
  const { idUsuario, fecha, isCaloriasQuemadas = true } = req.body;

  try {
    // Convertir la fecha a la zona horaria de 'America/Mexico_City'
    const fechaHoy = moment.tz(fecha, 'YYYY-MM-DD', 'America/Mexico_City');

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

    // Realizar la búsqueda en la base de datos
    const [alimentos, macronutrientes] = await Promise.all([
      AlimentoModel.find(query).populate('ingredientes').lean().sort({ fecha: -1 }),
      getNutrientesPorUsuario(idUsuario, todayStart, todayEnd, isCaloriasQuemadas)
    ]);

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
          score: alimento?.puntuacionSalud?.score || 0,
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

    // Devolver los alimentos con los campos solicitados
    return res.status(200).json({ alimentos: alimentosResponse, macronutrientes });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const editarNombreComida = async (req, res) => {
  const { id, nombre } = req.body;

  try {
    const updateAlimento = await AlimentoModel.findByIdAndUpdate(id,
      {
        nombre
      },
      { new: true }
    );
    return res.status(200).json({ alimentos: updateAlimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const editarPorcionComida = async (req, res) => {
  const { id, porciones } = req.body;

  try {
    const updateAlimento = await AlimentoModel.findByIdAndUpdate(id,
      {
        porciones
      },
      { new: true }
    );
    console.log(updateAlimento);
    return res.status(200).json({ alimentos: updateAlimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const getNutrientesPorUsuario = async (usuarioId, todayStart, todayEnd, isCaloriasQuemadas) => {
  try {
    // Obtenemos los resultados de la consulta agregada de los alimentos consumidos
    const resultados = await AlimentoModel.aggregate([
      {
        $match: {
          usuario: new mongoose.Types.ObjectId(usuarioId), // Corregido: usa 'new'
          fecha: { $gte: todayStart, $lte: todayEnd } // Filtra por rango de fechas en UTC ajustado
        }
      },
      {
        $project: {
          caloriasTotales: '$calorias', // Eliminamos la multiplicación
          proteinaTotal: '$proteina',
          carbohidratosTotales: '$carbohidratos',
          grasasTotales: '$grasas'
        }
      },
      {
        $group: {
          _id: null, // Agrupamos todo en un solo resultado
          totalCalorias: { $sum: '$caloriasTotales' },
          totalProteina: { $sum: '$proteinaTotal' },
          totalCarbohidratos: { $sum: '$carbohidratosTotales' },
          totalGrasas: { $sum: '$grasasTotales' }
        }
      }
    ]);

    const ejercicios = await EjercicioModel.aggregate([
      {
        $match: {
          usuario: new mongoose.Types.ObjectId(usuarioId),
          fecha: { $gte: todayStart, $lte: todayEnd }
        }
      },
      {
        $group: {
          _id: null,
          totalCaloriasQuemadas: { $sum: '$calorias' }
        }
      }
    ]);

    // console.log(ejercicios);

    const caloriasQuemadas = ejercicios.length
      ? Math.floor(ejercicios[0].totalCaloriasQuemadas)
      : 0;

    // console.log(Math.floor(resultados[0].totalCalorias), 'calorias totales');
    // console.log(caloriasQuemadas, 'calorias quemada');
    // console.log(((Math.floor(resultados[0].totalCalorias)) - (caloriasQuemadas)), 'resta');

    // Verificamos si existen los resultados

    if (resultados.length) {
      let totalCalorias = Math.floor(resultados[0].totalCalorias);
      if (isCaloriasQuemadas === false) {
        // totalCalorias = totalCalorias;
      } else {
        totalCalorias = totalCalorias - caloriasQuemadas;
      }
      return {
        totalCalorias,
        totalProteina: Math.floor(resultados[0].totalProteina),
        totalCarbohidratos: Math.floor(resultados[0].totalCarbohidratos),
        totalGrasas: Math.floor(resultados[0].totalGrasas),
        caloriasQuemadas
      };
    } else {
      let totalCalorias = 0;
      if (isCaloriasQuemadas === false) {
        totalCalorias = 0;
      } else {
        totalCalorias = totalCalorias - caloriasQuemadas;
      }
      return {
        _id: null,
        caloriasQuemadas,
        totalCalorias,
        totalProteina: 0,
        totalCarbohidratos: 0,
        totalGrasas: 0
      };
    }
  } catch (error) {
    console.error('Error en getNutrientesPorUsuario:', error);
    throw new Error('Error al procesar la consulta.');
  }
};

const favoritoComida = async (req, res) => {
  const { id, favorito } = req.body;

  try {
    const updateAlimento = await AlimentoModel.findByIdAndUpdate(id,
      {
        favorito
      },
      { new: true }
    );
    console.log(updateAlimento);
    return res.status(200).json({ alimentos: updateAlimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const deleteComida = async (req, res) => {
  const { id } = req.params;

  try {
    const updateAlimento = await AlimentoModel.findByIdAndDelete(id);
    return res.status(200).json({ alimentos: updateAlimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const deleteIngrediente = async (req, res) => {
  const { id } = req.params;

  try {
    const ingrediente = await IngredienteModel.findById(id);

    if (!ingrediente) {
      return res.status(404).json({ message: 'No se encontró el ingrediente.' });
    }

    ingrediente.eliminado = true;
    await ingrediente.save();

    const identificador = ingrediente._id;
    const calorias = ingrediente.calorias;
    const proteina = ingrediente.proteina;
    const carbohidratos = ingrediente.carbohidratos;
    const grasas = ingrediente.grasas;

    const alimento = await AlimentoModel.findOne({ ingredientes: identificador }).populate('ingredientes');
    if (!alimento) {
      return res.status(404).json({ message: 'No se encontró el alimento.' });
    }

    alimento.calorias = alimento.calorias - calorias;
    alimento.proteina = alimento.proteina - proteina;
    alimento.carbohidratos = alimento.carbohidratos - carbohidratos;
    alimento.grasas = alimento.grasas - grasas;
    alimento.save();

    return res.status(200).json({ ingrediente, alimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarIngrediente = async (req, res) => {
  const { id, calorias, proteina, carbohidratos, grasas } = req.body;

  try {
    // Actualizar el ingrediente directamente
    const ingrediente = await IngredienteModel.findByIdAndUpdate(
      id,
      {
        calorias: Math.floor(calorias),
        proteina: Math.floor(proteina),
        carbohidratos: Math.floor(carbohidratos),
        grasas: Math.floor(grasas)
      },
      { new: true } // Devuelve el documento actualizado
    );

    if (!ingrediente) {
      return res.status(404).json({ message: 'No se encontró el ingrediente.' });
    }

    // Buscar el alimento relacionado con el ingrediente actualizado
    const alimento = await AlimentoModel.findOne({ ingredientes: ingrediente._id }).populate('ingredientes');

    if (!alimento) {
      return res.status(404).json({ message: 'No se encontró el alimento.' });
    }

    return res.status(200).json({ ingrediente, alimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const actualizarAlimento = async (req, res) => {
  const { id, calorias, proteina, carbohidratos, grasas, porciones } = req.body;

  try {
    // Actualizar el ingrediente directamente
    const alimento = await AlimentoModel.findByIdAndUpdate(
      id,
      {
        calorias: Math.floor(calorias),
        proteina: Math.floor(proteina),
        carbohidratos: Math.floor(carbohidratos),
        grasas: Math.floor(grasas),
        porciones
      },
      { new: true } // Devuelve el documento actualizado
    );

    if (!alimento) {
      return res.status(404).json({ message: 'No se encontró el alimento.' });
    }

    return res.status(200).json({ alimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const agregarIngrediente = async (req, res) => {
  const { id } = req.params;

  try {
    const ingrediente = await IngredienteModel.findById(id);

    if (!ingrediente) {
      return res.status(404).json({ message: 'No se encontró el ingrediente.' });
    }

    ingrediente.eliminado = false;
    await ingrediente.save();

    const identificador = ingrediente._id;
    const calorias = ingrediente.calorias;
    const proteina = ingrediente.proteina;
    const carbohidratos = ingrediente.carbohidratos;
    const grasas = ingrediente.grasas;

    const alimento = await AlimentoModel.findOne({ ingredientes: identificador }).populate('ingredientes');
    if (!alimento) {
      return res.status(404).json({ message: 'No se encontró el alimento.' });
    }

    alimento.calorias = alimento.calorias + calorias;
    alimento.proteina = alimento.proteina + proteina;
    alimento.carbohidratos = alimento.carbohidratos + carbohidratos;
    alimento.grasas = alimento.grasas + grasas;
    alimento.save();

    return res.status(200).json({ ingrediente, alimento });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

const reportarComida = async (req, res) => {
  const { id, idUsuario, reporte } = req.body;

  try {
    const reporteNew = {
      usuario: idUsuario,
      reporte,
      alimento: id
    };

    const reporteCreado = await ReporteComidaModel.create(reporteNew);

    return res.status(200).json({ reporte: reporteCreado });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'No se pudo, intente más tarde.' });
  }
};

module.exports = {
  obtenerHistorialUsuario,
  editarNombreComida,
  editarPorcionComida,
  favoritoComida,
  deleteComida,
  reportarComida,
  deleteIngrediente,
  agregarIngrediente,
  actualizarIngrediente,
  actualizarAlimento
};
