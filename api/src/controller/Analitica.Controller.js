const AlimentoModel = require('../models/Alimentos.Model');
const moment = require('moment-timezone');

const obtenerNutricion = async (req, res) => {
  const { idUsuario, tipoBusqueda } = req.body;
  console.log(req.body);
  const fechaHoy = moment.tz('America/Mexico_City'); // Usamos la fecha actual en zona horaria México

  try {
    // Definir los tipos de búsqueda disponibles
    let startOfWeek, endOfWeek;
    switch (tipoBusqueda) {
      case 'Esta semana':
        startOfWeek = fechaHoy.clone().startOf('week'); // Lunes de esta semana
        endOfWeek = fechaHoy.clone().endOf('week'); // Domingo de esta semana
        break;
      case 'La semana pasada':
        startOfWeek = fechaHoy.clone().subtract(1, 'week').startOf('week');
        endOfWeek = fechaHoy.clone().subtract(1, 'week').endOf('week');
        break;
      case 'Hace 2 semanas':
        startOfWeek = fechaHoy.clone().subtract(2, 'weeks').startOf('week');
        endOfWeek = fechaHoy.clone().subtract(2, 'weeks').endOf('week');
        break;
      case 'Hace 3 semanas':
        startOfWeek = fechaHoy.clone().subtract(3, 'weeks').startOf('week');
        endOfWeek = fechaHoy.clone().subtract(3, 'weeks').endOf('week');
        break;
      default:
        return res.status(400).json({ error: 'Tipo de búsqueda no válido' });
    }

    // Buscar los alimentos del usuario dentro del rango de fechas correspondiente
    const query = {
      usuario: idUsuario,
      fecha: {
        $gte: startOfWeek.toDate(),
        $lte: endOfWeek.toDate()
      }
    };

    console.log(query);

    const alimentos = await AlimentoModel.find(query);

    // if (!alimentos.length) {
    //   return res.status(404).json({ message: 'No se encontraron alimentos para esta semana.' });
    // }

    // Inicializar las iniciales de los días de la semana
    const diasSemana = ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'];

    // Calcular el promedio de calorías por día
    const caloriasPorDia = {};
    let caloriasTotales = 0; // Inicializar las calorías totales

    alimentos.forEach((alimento) => {
      const dia = moment(alimento.fecha).day(); // Día de la semana (0 = Domingo, 1 = Lunes, ..., 6 = Sábado)
      if (!caloriasPorDia[dia]) {
        caloriasPorDia[dia] = [];
      }
      caloriasPorDia[dia].push(alimento.calorias);
      caloriasTotales += alimento.calorias; // Sumar las calorías totales
    });

    // Calcular el promedio de calorías por día (siempre como entero)
    const promedioPorDia = {};
    Object.keys(caloriasPorDia).forEach((dia) => {
      const caloriasDelDia = caloriasPorDia[dia];
      const promedio = Math.round(caloriasDelDia.reduce((acc, calorias) => acc + calorias, 0) / caloriasDelDia.length);
      promedioPorDia[dia] = promedio;
    });

    // Calcular el promedio general de la semana (siempre como entero)
    const promedioGeneral = Math.round(caloriasTotales / alimentos.length);

    // Mapear los resultados a los días de la semana con iniciales
    const respuestaConDias = diasSemana.map((dia, index) => {
      return {
        dia,
        promedio: promedioPorDia[index] || 0 // Si no hay datos para un día, asignar 0
      };
    });

    return res.status(200).json({ caloriasTotales: Math.floor(caloriasTotales), promedioGeneral, dias: respuestaConDias });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error });
  }
};

module.exports = { obtenerNutricion };
