const nodemailer = require('nodemailer');

const host = 'macrolife.app';
const port = 465;
const user = 'envia@macrolife.app';
const pass = 's6F&S=j_gyM$';

const transporter = nodemailer.createTransport({
  host,
  port,
  auth: {
    user,
    pass
  }
});

const sendMail = async (html, subject, correos, files = [], from = null, nombre = null) => {
  try {
    let fromA = `<${user}> "Macro Life" `;

    if (from) {
      fromA = `<${from}> "${nombre}" `;
    }

    console.log(from, nombre);

    const mailOptions = {
      from: fromA,
      to: correos,
      subject,
      html,
      attachments: files
    };

    const info = await transporter.sendMail(mailOptions);

    return info;
  } catch (error) {
    console.log('Error al enviar correo', error);
    return error;
  }
};

module.exports = { sendMail };
