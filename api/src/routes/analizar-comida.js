const Router = require('express');
const { analizarComida } = require('../controller/Analizar.Comida.Controller');

const router = Router();

router.post('/', analizarComida);

module.exports = router;
