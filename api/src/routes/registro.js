const Router = require('express');
const { registroController } = require('../controller/Registro.Controller');

const router = Router();

router.post('/', registroController);

module.exports = router;
