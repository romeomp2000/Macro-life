const Alimento = require('../models/Alimentos.Model'); // Ajusta la ruta si es necesario

const obtenerAlimentosPorDias = async (req, res) => {
  try {
    const { id } = req.params;

    // Fecha actual
    const hoy = new Date();
    // Obtener el inicio de la semana (Lunes) y el final (Domingo)
    const inicioSemana = new Date(hoy.setDate(hoy.getDate() - hoy.getDay() + 1));
    const finSemana = new Date(hoy.setDate(inicioSemana.getDate() + 6));

    // Consultar los alimentos del usuario en el rango de la semana actual
    const alimentos = await Alimento.find({
      usuario: id,
      fecha: { $gte: inicioSemana, $lte: finSemana }
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
      const dia = new Date(alimento.fecha).getDay(); // Obtener el día (0 = Domingo, 6 = Sábado)

      const diasEnEspanol = ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'];
      diasSemana[diasEnEspanol[dia]] = true; // Marcar el día como true
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
