const Router = require('express');
const { obtenerConfiguraciones } = require('../controller/Configuraciones.Controller');

const router = Router();

router.get('/', obtenerConfiguraciones);

module.exports = router;
