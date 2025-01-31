const mailSoporte = ({ nombre, descripcion }) => {
  return ` <meta charset="utf-8" />
    <table
      border="0"
      align="center"
      cellpadding="0"
      cellspacing="0"
      style="width: 600px"
    >
      <tr>
        <td
          align="center"
          valign="top"
          style="background-color: #f2f2f2; padding: 10px"
        >
          <table
            border="0"
            align="center"
            cellpadding="0"
            cellspacing="0"
            style="width: 100%; padding: 20px"
          >
            <tr>
              <td
                align="center"
                valign="top"
                style="width: 100%; padding: 20px; background-color: #ffffff"
              >
                <table
                  border="0"
                  align="center"
                  cellpadding="0"
                  cellspacing="0"
                  style="width: 100%"
                >
                  <tr>
                    <td
                      align="center"
                      valign="middle"
                      style="
                        width: 100%;
                        text-align: left;
                        vertical-align: middle;
                      "
                    >
                      <a href="https://macrolife.app/" target="_blank"
                        ><img
                          src="https://macrolife.app/images/logo/logo_macrolife_196x36_negro.png"
                          alt="MACRO LIFE Controla lo que comes, vive mejor."
                          title="MACRO LIFE Controla lo que comes, vive mejor."
                      /></a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td
                align="center"
                valign="top"
                style="
                  width: 100%;
                  padding-right: 20px;
                  padding-left: 20px;
                  padding-bottom: 20px;
                  padding-top: 30px;
                  background-color: #ffffff;
                "
              >
                <table
                  border="0"
                  align="center"
                  cellpadding="0"
                  cellspacing="0"
                  style="width: 100%"
                >
                  <tr>
                    <td
                      style="
                        width: 100%;
                        font-family: Helvetica, Arial, sans-serif;
                        font-size: 15px;
                        color: #000000;
                        text-align: left;
                        vertical-align: top;
                        font-weight: bold;
                      "
                    >
                      Nombre: ${nombre}
                    </td>
                  </tr>
                  <tr>
                    <td
                      style="
                        width: 100%;
                        font-family: Helvetica, Arial, sans-serif;
                        font-size: 14px;
                        color: #232323;
                        line-height: 23px;
                        text-align: left;
                        vertical-align: top;
                        width: 400;
                      "
                    >
                      ${descripcion}
                    </td>
                  </tr>
                  <tr>
                    <td
                      style="
                        width: 100%;
                        border-bottom-style: dashed;
                        border-bottom-width: 1px;
                        border-bottom-color: #cccccc;
                      "
                    >
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 100%; text-align: center">&nbsp;</td>
                  </tr>

                  <tr>
                    <td
                      style="
                        width: 100%;
                        font-family: Helvetica, Arial, sans-serif;
                        font-size: 14px;
                        color: #232323;
                        line-height: 23px;
                        text-align: center;
                        vertical-align: top;
                        width: normal;
                      "
                    >
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td
                      style="
                        width: 100%;
                        font-family: Helvetica, Arial, sans-serif;
                        font-size: 14px;
                        color: #232323;
                        line-height: 23px;
                        text-align: center;
                        vertical-align: top;
                        width: normal;
                      "
                    >
                      &nbsp;
                    </td>
                  </tr>

                  <tr>
                    <td style="width: 100%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td
                      align="center"
                      valign="middle"
                      style="
                        width: 100%;
                        font-family: Helvetica, Arial, sans-serif;
                        font-size: 12px;
                        color: #685f5f;
                        line-height: 23px;
                        text-align: center;
                        vertical-align: middle;
                      "
                    >
                      © 2024 Derechos Reservados |
                      <a
                        href="http://www.macrolife.app/"
                        target="_blank"
                        style="color: #000000; text-decoration: none"
                        title="MACRO LIFE Controla lo que comes, vive mejor."
                        alt="MACRO LIFE Controla lo que comes, vive mejor."
                      >
                        Macro Life</a
                      >
                      - Design by
                      <a
                        style="color: #000000; text-decoration: none"
                        href="https://www.posibilidades.com.mx/"
                        target="_blank"
                        title="Design by www.posibilidades.com.mx"
                        alt="Design by www.posibilidades.com.mx"
                        >Posibilidades</a
                      >
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>`;
};

module.exports = mailSoporte;
