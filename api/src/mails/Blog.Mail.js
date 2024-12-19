const mail = ({ tipo, value }) => {
  return `
  <meta charset="utf-8">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 600px;">
  <tr>
    <td align="center" valign="top" style="background-color: #F2F2F2;padding: 10px;">
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;padding:20px;">
        <tr>
          <td align="center" valign="top" style="width:100%;padding:20px; background-color:#FFFFFF;">
            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
              <tr>
                <td align="center" valign="middle" style="width:100%; text-align:left; vertical-align:middle;"><a
                    href="https://macrolife.app/" target="_blank"><img
                      src="https://macrolife.app/images/logo/logo_macrolife_196x36_negro.png"
                      alt="MACRO LIFE Controla lo que comes, vive mejor."
                      title="MACRO LIFE Controla lo que comes, vive mejor." /></a></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="center" valign="top"
            style="width:100%;padding-right:20px; padding-left:20px; padding-bottom:20px; padding-top:30px; background-color:#FFFFFF;">
            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:18px; color:#000000; text-align:left; vertical-align:top;font-weight: bold;">
                  ¡Hola!</td>
              </tr>
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#232323; line-height:23px; text-align:left; vertical-align:top; width: 400;">
                  Te has suscrito correctamente a nuestro Blog. En breve te enviaremos noticias interesantes sobre
                  <strong>Macro Life</strong>.</td>
              </tr>
              <tr>
                <td
                  style="width:100%; border-bottom-style:dashed; border-bottom-width:1px; border-bottom-color:#cccccc;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="width:100%; text-align:center;">&nbsp;</td>
              </tr>
              <tr>
                <td align="center" valign="top" style="width:100%; text-align:center;">
                  <table border="0" cellspacing="1" cellpadding="7" style="width:100%;">
                    <tr>
                      <td align="left" valign="top"
                        style="width:30%;font-family: Helvetica, Arial, sans-serif;font-size: 14px;font-weight: normal;color: #FFF;text-align: left;vertical-align: top; background-color:#232323; border: 1px solid #232323; padding:8px; border-left-style: solid; border-left-color:#000000; border-left-width:3px;">
                        ${tipo}:</td>
                      <td align="left" valign="top"
                        style="width:70%;font-family: Helvetica, Arial, sans-serif;font-size: 14px;font-weight: normal;color:#000000;text-align: left;vertical-align: top; background-color:#f6f6f6; border-radius: 4px; border: 1px solid #FFF; padding:8px;">
                        ${value}</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td
                  style="width:100%; border-bottom-style:dashed; border-bottom-width:1px; border-bottom-color:#cccccc;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#232323; line-height:23px; text-align:center; vertical-align:top; width: normal;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td align="center" valign="top"
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:18px; color:#000000; text-align:center; vertical-align:top;font-weight: bold;">
                  Descarga la App</td>
              </tr>
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#232323; line-height:23px; text-align:center; vertical-align:top; width: normal;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#232323; line-height:23px; text-align:center; vertical-align:top; width: normal;">
                  <table border="0" align="center" cellpadding="0" cellspacing="0"
                    style="width:70%; text-align:center;">
                    <tr>
                      <th align="center" valign="middle" scope="col"><a href="https://macrolife.app/descargar_app/"
                          target="_blank"><img
                            src="https://macrolife.app/images/botones/boton_descarga_app_156x50_app_store.png"
                            title="Descárgala en la App Store" alt="Descárgala en la App Store" /></a></th>
                      <th align="center" valign="middle" scope="col" style="width:20px;">&nbsp;</th>
                      <th align="center" valign="middle" scope="col"><a href="https://macrolife.app/descargar_app/"
                          target="_blank"><img
                            src="https://macrolife.app/images/botones/boton_descarga_app_156x50_google_play.png"
                            title="Descárgala en Google Play" alt="Descárgala en Google Play" /></a></th>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#232323; line-height:23px; text-align:center; vertical-align:top; width: normal;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td align="center" valign="middle"
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:14px; color:#685f5f; line-height:26px; text-align:center; vertical-align:top; width: normal;">
                  Si tienes dudas ó comentarios, comunicate con nosotros.<br /> <span style="font-weight:600;"><a
                      href="mailto:contacto@macrolife.app" target="_blank"
                      title="Escríbenos a nuestro correo electrónico" alt="Escríbenos a nuestro correo electrónico"
                      style="color:#685f5f; text-decoration:none;"><img
                        src="https://macrolife.app/images/icono/iconos_contacto_notificacion_16x16_correo.png"
                        width="16" height="16" alt="" /> contacto@macrolife.app</a>&nbsp;&nbsp;&nbsp;<a
                      href="http://www.macrolife.app/" target="_blank" title="Visita nuestro sitio web"
                      alt="Visita nuestro sitio web" style="color:#685f5f; text-decoration:none;"><img
                        src="https://macrolife.app/images/icono/iconos_contacto_notificacion_16x16_sitio.png" width="16"
                        height="16" alt="" /> www.macrolife.app</a></span></td>
              </tr>
              <tr>
                <td
                  style="width:100%; border-bottom-style:dashed; border-bottom-width:1px; border-bottom-color:#cccccc;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="width:100%;">&nbsp;</td>
              </tr>
              <tr>
                <td align="center" valign="middle"
                  style="width:100%;font-family: Helvetica, Arial, sans-serif; font-size:12px; color:#685f5f; line-height:23px; text-align:center; vertical-align:middle;">
                  © 2024 Derechos Reservados | <a href="http://www.macrolife.app/" target="_blank"
                    style="color:#000000; text-decoration:none;" title="MACRO LIFE Controla lo que comes, vive mejor."
                    alt="MACRO LIFE Controla lo que comes, vive mejor."> Macro Life</a> - Design by <a
                    style="color:#000000;text-decoration:none;" href="https://www.posibilidades.com.mx/" target="_blank"
                    title="Design by www.posibilidades.com.mx"
                    alt="Design by www.posibilidades.com.mx">Posibilidades</a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
  `;
};

module.exports = mail;
