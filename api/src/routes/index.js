const { PORT } = require("../config/index.js");
const Router = require("express");
const { readdirSync } = require("fs");
// require("colors");

const router = Router();

const pathRouter = `${__dirname}`;

const removeExtension = (fileName) => {
  return fileName.split(".").shift();
};

// eslint-disable-next-line array-callback-return
readdirSync(pathRouter).filter((file) => {
  const fileWithOutExt = removeExtension(file);
  const skip = ["index"].includes(fileWithOutExt);

  if (!skip) {
    router.use(`/${fileWithOutExt}`, require(`./${fileWithOutExt}`));
    const ruta = `http://localhost:${PORT}/api/${fileWithOutExt}`;
    console.log(`CARGAR RUTA ----> ${ruta}`);
  }
});

module.exports = router;
