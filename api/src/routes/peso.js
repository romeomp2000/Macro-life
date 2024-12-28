const Router = require('express');
const { actualizarPesoObjetivo, actualizarPesoActual } = require('../controller/Peso.Controller');

const router = Router();

router.post('/objetivo', actualizarPesoObjetivo);
router.post('/actual', actualizarPesoActual);

module.exports = router;
