const SuscripcionBlog = require('../models/Suscripcion.Blog.Model');
const MailSuscripcion = require('../mails/Blog.Mail');
const Mail = require('../config/mail');

const RegistrarBlog = async (req, res) => {
  const { input } = req.body;

  try {
    if (!input) {
      return res.status(400).send({ error: 'Input no proporcionado' });
    }

    const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(input);
    const isNumber = /^\d+$/.test(input);

    if (isEmail) {
      await SuscripcionBlog.create({
        correo: input
      });

      const html = MailSuscripcion({ tipo: 'Correo electrónico', value: input });

      Mail.sendMail(html, 'Gracias por suscribirse a Macro Life', input);
      return res.status(200).json({ message: 'Se ha registrado correctamente' });
    } else if (isNumber) {
      await SuscripcionBlog.create({
        telefono: input
      });
      return res.status(200).json({ message: 'Se ha registrado correctamente' });
    } else {
      return res.status(400).json({ message: 'No es una teléfono ni correo electrónicos' });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: 'Error: Intente más tarde' });
  }
};

module.exports = { RegistrarBlog };
