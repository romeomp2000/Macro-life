const Router = require("express");
const { enviarCorreoSoporte } = require("../controller/correo.Controller");

const router = Router();

router.post("/", enviarCorreoSoporte);

module.exports = router;
