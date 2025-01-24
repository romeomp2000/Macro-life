const Router = require('express');
const { registroController, actualizarObejtivos } = require('../controller/Registro.Controller');

const router = Router();

router.post('/', registroController);
router.post('/objetivos', actualizarObejtivos);

module.exports = router;
