const Alimento = require('../models/Alimentos.Model'); // Ajusta la ruta si es necesario
const moment = require('moment-timezone');

const obtenerAlimentosPorDias = async (req, res) => {
  try {
    const { id } = req.params;

    // Configurar la zona horaria de México
    const zonaHoraria = 'America/Mexico_City';

    // Fecha actual en la zona horaria de México
    const hoy = moment().tz(zonaHoraria);

    // Obtener el inicio de la semana (Lunes) y el final (Domingo)
    const inicioSemana = hoy.clone().startOf('isoWeek'); // Lunes
    const finSemana = hoy.clone().endOf('isoWeek'); // Domingo

    // Consultar los alimentos del usuario en el rango de la semana actual
    const alimentos = await Alimento.find({
      usuario: id,
      fecha: {
        $gte: inicioSemana.toDate(),
        $lte: finSemana.toDate()
      }
    });

    // Crear un mapa inicial con días de la semana abreviados
    const diasSemana = {
      Lun: false,
      Mar: false,
      Mie: false,
      Jue: false,
      Vie: false,
      Sab: false,
      Dom: false
    };

    // Iterar sobre los alimentos y marcar los días correspondientes
    alimentos.forEach(alimento => {
      const dia = moment(alimento.fecha).tz(zonaHoraria).isoWeekday(); // Obtener el día (1 = Lunes, 7 = Domingo)

      const diasEnEspanol = ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'];
      diasSemana[diasEnEspanol[dia - 1]] = true; // Marcar el día como true
    });

    return res.status(200).json(diasSemana);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Error al obtener los alimentos por días' });
  }
};

module.exports = {
  obtenerAlimentosPorDias
};
