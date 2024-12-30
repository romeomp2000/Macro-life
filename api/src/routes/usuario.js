const Router = require('express');
const { buscaUsuario, buscaAuth } = require('../controller/Usuario.Controller');
const router = Router();

router.get('/buscar/:id', buscaUsuario);

router.post('/buscar-auth', buscaAuth);

module.exports = router;
