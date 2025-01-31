const { sendMailSoporte } = require("../config/mail");
const mailSoporte = require("../mails/Soporte.Mail");

const enviarCorreoSoporte = async (req, res) => {
  const { usuario, nombre, correo, descripcion } = req.body;

  try {
    const html = mailSoporte({
      nombre: nombre,
      descripcion: `${descripcion} <strong>correo:${correo}</strong>`,
    });
    sendMailSoporte(
      html,
      `Soporte ${usuario}`,
      "soporte@macrolife.app",
      [],
      correo,
      nombre
    );

    return res.status(200).json({ message: "Correo enviado" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Error: Intente más tarde" });
  }
};

module.exports = { enviarCorreoSoporte };
