require("dotenv").config();
const { UPLOADS_FOLDER } = require("./config");
const express = require("express");
const router = require("./routes");
const morgan = require("morgan");
const cors = require("cors");
const path = require("path");
// require("colors");

const app = express();

app.use(cors({ origin: "*" }));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(morgan("dev"));

//* Routes
app.use("/api", router);

// app.use(
//   `/${UPLOADS_FOLDER}`,
//   express.static(path.join(__dirname, "../public/"))
// );

// app.use(express.static(path.join(__dirname, "../public/")));

module.exports = app;
