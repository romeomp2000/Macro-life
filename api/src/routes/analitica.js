const Router = require('express');
const { obtenerNutricion, obtenerPeso } = require('../controller/Analitica.Controller');

const router = Router();

router.post('/nutricion', obtenerNutricion);
router.post('/peso', obtenerPeso);
module.exports = router;
