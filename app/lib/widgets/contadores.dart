import 'package:fep/config/theme.dart';
import 'package:fep/models/contadores_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Contadores extends StatelessWidget {
  final ContadoresModel contadores;
  final bool? loading;
  const Contadores({
    super.key,
    required this.contadores,
    this.loading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (loading == true)
            const LinearProgressIndicator()
          else
            Column(
              children: [
                Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        minLeadingWidth: 20,
                        leading: SvgPicture.network(
                          'https://www.plataforma.fep.mx/images/icons/red/icon_seccion_60x60_02.svg',
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFCC3300), BlendMode.srcIn),
                        ),
                        title: Text(
                          'MIS TIMBRES',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            color: const Color(0xFF002A3A),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'No. timbres:',
                                  style: TextStyle(
                                    color: blackTheme1_,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: contadores.timbresdisponibles == 0
                                        ? Colors.redAccent
                                        : greenTheme1_,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '${contadores.timbresdisponibles ?? '0'}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Expiran:',
                                  style: TextStyle(
                                      color: blackTheme1_, fontSize: 14),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: contadores.fechaExpiracionColor_,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    contadores.fechaexpiran ?? '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (contadores.avisovencimiento != '')
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: contadores.avisoVencimientoColor_,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                contadores.avisovencimiento ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (contadores.timbresdisponibles == 0)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Get.toNamed('/comprar');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        greenTheme1_,
                                      ),
                                      elevation: WidgetStateProperty.all(3),
                                    ),
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Compre un nuevo paquete',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        minLeadingWidth: 20,
                        leading: SvgPicture.network(
                          'https://www.plataforma.fep.mx/images/icons/red/icon_seccion_60x60_02.svg',
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFCC3300), BlendMode.srcIn),
                        ),
                        title: Text(
                          'MIS SELLOS',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            color: const Color(0xFF002A3A),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Activación del certificado:',
                                style: TextStyle(
                                    color: blackTheme1_, fontSize: 14)),
                            const SizedBox(width: 5),
                            if (contadores.fechaPeriodo != '')
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: greenTheme1_,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  contadores.fechaPeriodo ?? '',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Expiración del certificado:',
                              style:
                                  TextStyle(color: blackTheme1_, fontSize: 14),
                            ),
                            const SizedBox(width: 5),
                            if (contadores.fechaPeriodo != '')
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: greenTheme1_,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  contadores.fechaPeriodo ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (contadores.mensajesellos != '')
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: contadores.mensajeSellosColor_,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                contadores.mensajesellos ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            if (contadores.timbresdisponibles == 0)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Get.toNamed('/comprar');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        greenTheme1_,
                                      ),
                                      elevation: WidgetStateProperty.all(3),
                                    ),
                                    icon: const Icon(
                                      Icons.key_sharp,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Subir sellos',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
