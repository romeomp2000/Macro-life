const Router = require("express");
const {
  suscribirUsuario,
  pruebaGratis,
} = require("../controller/Suscripcion.Controller");

const router = Router();

router.post("/usuario", suscribirUsuario);

router.post("/prueba-gratis", pruebaGratis);

module.exports = router;
