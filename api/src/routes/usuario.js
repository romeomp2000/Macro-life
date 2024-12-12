const Router = require('express');
const { buscaUsuario } = require('../controller/Usuario.Controller');
const router = Router();

router.get('/buscar/:id', buscaUsuario);

module.exports = router;
