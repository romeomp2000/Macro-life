const AlimentoModel = require('../models/Alimentos.Model');
const PesoHistorial = require('../models/PesoHistorial.Model');
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

const obtenerPeso = async (req, res) => {
  try {
    const { idUsuario, tipoBusqueda } = req.body;
    let fechaInicio;

    // Determinar el rango de fechas según el tipo de búsqueda
    switch (tipoBusqueda) {
      case '90 Días':
        fechaInicio = moment().subtract(90, 'days').toDate(); // 90 días atrás
        break;
      case '6 Meses':
        fechaInicio = moment().subtract(6, 'months').toDate(); // 6 meses atrás
        break;
      case '1 Año':
        fechaInicio = moment().subtract(1, 'year').toDate(); // 1 año atrás
        break;
      case 'Todo el tiempo':
        fechaInicio = null; // Sin filtro de fecha
        break;
      default:
        return res.status(400).json({ message: 'Tipo de búsqueda no válido.' });
    }

    // Buscar el historial de peso del usuario
    let historial;
    if (fechaInicio) {
      // Filtrar por fecha de inicio si existe
      historial = await PesoHistorial.find({
        usuario: idUsuario,
        fecha: { $gte: fechaInicio }
      }).sort({ fecha: 1 });
    } else {
      // Buscar todo el historial si no hay filtro de fecha
      historial = await PesoHistorial.find({ usuario: idUsuario }).sort({ fecha: 1 });
    }

    if (!historial.length) {
      return res.status(404).json({ message: 'No se encontró historial de peso para este usuario.' });
    }

    // Calcular peso máximo y mínimo
    const pesos = historial.map(h => h.peso);
    let maxPeso = Math.max(...pesos);
    let minPeso = Math.min(...pesos);

    // Ajustar el máximo y mínimo a múltiplos de 10
    if (maxPeso >= 10) {
      maxPeso = Math.floor(maxPeso / 10) * 10; // Redondear hacia abajo al múltiplo más cercano de 10
    }
    if (minPeso >= 10) {
      minPeso = Math.floor(minPeso / 10) * 10; // Redondear hacia abajo al múltiplo más cercano de 10
    }

    // Ajustar límites del eje Y
    const ejeYMaximo = maxPeso + 10;
    const ejeYMinimo = Math.max(minPeso - 10, 0); // Asegurarse de que el mínimo no sea menor que 0

    // Formatear los datos para el gráfico
    const chartData = historial.map((registro, index) => ({
      x: moment(registro.fecha).format('YYYY-MM-DD'),
      y: registro.peso,
      fecha: registro.fecha
    })).sort((a, b) => a.fecha - b.fecha);

    return res.json({
      data: chartData,
      ejeY: {
        maximo: ejeYMaximo,
        minimo: ejeYMinimo
      }
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error });
  }
};

module.exports = {
  obtenerNutricion,
  obtenerPeso
};
