require('dotenv').config();
require('./config/database.js');
// require('./utils/initialSetup');
const moment = require('moment-timezone');
moment.tz.setDefault('America/Mexico_City');
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const router = require('./routes/index'); // Importando rutas con require
const fileUpload = require('express-fileupload');
const path = require('path');
require('./config/initialSetup.js');
// const { createProxyMiddleware } = require('http-proxy-middleware');

// const history = require('connect-history-api-fallback');

// import bodyParser from 'body-parser';
// Inicio de express
const app = express();

// Middlewares
app.use(cors());

// para que express pueda entender los datos que vienen de un formulario

app.use((req, res, next) => {
  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  next();
});

app.use(fileUpload({
  useTempFiles: true,
  tempFileDir: '/tmp/',
  createParentPath: true,
  uriDecodeFileNames: false, // No decodificar nombres de archivo para respetar acentos
  safeFileNames: false, // No modificar el nombre del archivo
  preserveExtension: true,
  abortOnLimit: true,
  responseOnLimit: 'File size limit has been reached',
  limitHandler: false,
  hashAlgorithm: 'md5',
  defCharset: 'utf8',
  defParamCharset: 'utf8'
}));

app.use((req, res, next) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  next();
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// app.use(bodyParser());

app.use(morgan('dev'));

// Routes

app.use('/api', router);

// app.use(history());

// archivos estáticos (imágenes, css, js)
app.use('/assets', express.static(path.join(__dirname, 'assets')));

// Subir imágenes (uploads)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// export default app;
module.exports = app;
