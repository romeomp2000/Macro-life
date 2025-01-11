const Router = require('express');
const { analizarComida, analizarComidaTexto } = require('../controller/Analizar.Comida.Controller');

const router = Router();

router.post('/', analizarComida);
router.post('/describir', analizarComidaTexto);
module.exports = router;
