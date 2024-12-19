const Router = require('express');
const { suscribirUsuario } = require('../controller/Suscripcion.Controller');

const router = Router();

router.post('/usuario', suscribirUsuario);

module.exports = router;
