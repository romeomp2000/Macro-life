const Router = require('express');
const { createEjercicio, obtenerEjercicio, createEjercicioPesas, eliminarEjercicio, describirEjercicioIA } = require('../controller/Ejercicio.Controller');

const router = Router();

router.post('/ejecutar', createEjercicio);
router.post('/pesas', createEjercicioPesas);
router.post('/obtener', obtenerEjercicio);
router.post('/describir', describirEjercicioIA);
router.delete('/:id', eliminarEjercicio);

module.exports = router;
