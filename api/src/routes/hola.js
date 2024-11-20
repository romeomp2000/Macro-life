const Router = require("express");
const { holaMundo } = require("../controller/hola");

const router = Router();

router.get("/", holaMundo);

module.exports = router;
