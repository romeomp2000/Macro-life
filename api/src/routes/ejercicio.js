const Router = require('express');
const { createEjercicio, obtenerEjercicio } = require('../controller/Ejercicio.Controller');

const router = Router();

router.post('/ejecutar', createEjercicio);
router.post('/obtener', obtenerEjercicio);

module.exports = router;
