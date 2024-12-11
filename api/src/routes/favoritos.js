const Router = require('express');
const { obtenerFavoritos, favoritoAlimento } = require('../controller/Favoritos.Controller');

const router = Router();

router.post('/', obtenerFavoritos);
router.post('/favorito-alimento', favoritoAlimento);

module.exports = router;
