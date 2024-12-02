const Router = require('express');
const { obtenerHistorialUsuario } = require('../controller/Registros.Comida.Controller');

const router = Router();

router.post('/', obtenerHistorialUsuario);

module.exports = router;
