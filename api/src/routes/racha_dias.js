const Router = require('express');
const { obtenerAlimentosPorDias } = require('../controller/Racha.Dias.Controller');

const router = Router();

router.get('/:id', obtenerAlimentosPorDias);

module.exports = router;
