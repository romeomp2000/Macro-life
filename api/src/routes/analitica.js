const Router = require('express');
const { obtenerNutricion } = require('../controller/Analitica.Controller');

const router = Router();

router.post('/nutricion', obtenerNutricion);
module.exports = router;
