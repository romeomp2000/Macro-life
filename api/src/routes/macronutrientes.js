const Router = require('express');
const { EditarMacronutrientesDiario } = require('../controller/Nutrientes.Controller');

const router = Router();

router.put('/', EditarMacronutrientesDiario);

module.exports = router;
