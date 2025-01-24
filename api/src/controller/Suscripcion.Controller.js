const VentasModel = require("../models/ventas.Model");
const UsuarioModel = require("../models/Usuario.Model");
const moment = require("moment-timezone");
const suscribirUsuario = async (req, res) => {
  const { idUsuario, producto, total, identificador, metodoPago } = req.body;

  try {
    console.log(req.body);
    const fechaActual = moment.tz("America/Mexico_City");

    let fechaVigencia = null;

    if (producto === "Mensual") {
      // Sumar 1 mes
      fechaVigencia = fechaActual.clone().add(1, "month");
    } else if (producto === "Anual") {
      // Sumar 1 año
      fechaVigencia = fechaActual.clone().add(1, "year");
    }

    const findUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { fechaVencimiento: fechaVigencia },
      { new: true } // Opcional: devuelve el documento actualizado
    );

    if (!findUsuario) {
      return res.json(400).json({ message: "Usuario no encontrado" });
    }

    const ventaNueva = await VentasModel.create({
      usuario: findUsuario._id,
      total,
      producto,
      identificador,
      metodoPago,
      fecha: fechaActual,
    });

    return res.status(200).json({
      usuario: findUsuario,
      venta: ventaNueva,
      message: "Muchas Gracias por suscribirse a Macro Life",
    });
  } catch (error) {
    console.log(error);
    return res
      .json(500)
      .json({ message: "Ocurrió un error intente más tarde" });
  }
};

const pruebaGratis = async (req, res) => {
  const { idUsuario, producto, total } = req.body;

  try {
    const fechaActual = moment.tz("America/Mexico_City");

    let fechaVigencia = null;
    if (producto === "Anual") {
      // Sumar 1 año
      fechaVigencia = fechaActual.clone().add(3, "days");
    }

    const findUsuario = await UsuarioModel.findByIdAndUpdate(
      idUsuario,
      { fechaVencimiento: fechaVigencia },
      { new: true }
    );

    if (!findUsuario) {
      return res.json(400).json({ message: "Usuario no encontrado" });
    }

    const ventaNueva = await VentasModel.create({
      usuario: findUsuario._id,
      total,
      producto,
      identificador: "FREE 3 DAYS",
      metodoPago: "FREE",
      fecha: fechaActual,
    });

    return res.status(200).json({
      usuario: findUsuario,
      venta: ventaNueva,
      message: "Muchas Gracias por suscribirse a Macro Life",
    });
  } catch (error) {
    console.log(error);
    return res
      .json(500)
      .json({ message: "Ocurrió un error intente más tarde" });
  }
};

module.exports = {
  suscribirUsuario,
  pruebaGratis,
};
