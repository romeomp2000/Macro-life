const Router = require('express');
const { searchAlimento, createAlimento } = require('../controller/Food.Database.Controller');

const router = Router();

router.post('/', searchAlimento);
router.post('/nuevo-alimento', createAlimento);

module.exports = router;
