const Router = require('express');
const { buscaUsuario, buscaAuth, actualizarNombre, actualizarTelefono, actualizarCorreo, deleteUsuario, actualizarAltura, actualizarPeso, actualizarFechaNacimiento, actualizarGenero } = require('../controller/Usuario.Controller');
const router = Router();

router.get('/buscar/:id', buscaUsuario);

router.post('/buscar-auth', buscaAuth);

router.put('/nombre', actualizarNombre);
router.put('/telefono', actualizarTelefono);
router.put('/correo', actualizarCorreo);
router.put('/altura', actualizarAltura);
router.put('/peso', actualizarPeso);
router.put('/nacimiento', actualizarFechaNacimiento);
router.put('/genero', actualizarGenero);
router.post('/eliminar-cuenta', deleteUsuario);

module.exports = router;
