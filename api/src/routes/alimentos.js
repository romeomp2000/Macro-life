const Router = require('express');
const { obtenerHistorialUsuario, editarNombreComida, editarPorcionComida, actualizarAlimento, actualizarIngrediente, favoritoComida, deleteComida, reportarComida, deleteIngrediente, agregarIngrediente } = require('../controller/Registros.Comida.Controller');

const router = Router();

router.post('/', obtenerHistorialUsuario);
router.put('/nombre', editarNombreComida);
router.put('/porciones', editarPorcionComida);
router.put('/favorito', favoritoComida);
router.delete('/eliminar-alimento/:id', deleteComida);
router.post('/reporte', reportarComida);
router.delete('/eliminar-ingrediente/:id', deleteIngrediente);
router.put('/agregar-ingrediente/:id', agregarIngrediente);
router.put('/ingrediente', actualizarIngrediente);
router.put('/alimento', actualizarAlimento);

module.exports = router;
