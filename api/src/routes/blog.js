const Router = require('express');
const { RegistrarBlog } = require('../controller/Blog.Controller');

const router = Router();

router.post('/registro', RegistrarBlog);
module.exports = router;
