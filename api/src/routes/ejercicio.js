const Router = require('express');
const { createEjercicio, obtenerEjercicio, createEjercicioPesas, describirEjercicioIA } = require('../controller/Ejercicio.Controller');

const router = Router();

router.post('/ejecutar', createEjercicio);
router.post('/pesas', createEjercicioPesas);
router.post('/obtener', obtenerEjercicio);
router.post('/describir', describirEjercicioIA);

module.exports = router;
