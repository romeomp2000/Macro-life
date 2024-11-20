import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HankFooterController extends GetxController {
  final String year = DateTime.now().year.toString();
  final Uri urlPosibilidades = Uri.parse('https://www.posibilidades.com.mx');
  final Uri urlHank = Uri.parse('https://hank.mx');
  final Uri urlTerminos = Uri.parse('https://fep.mx/terminos_condiciones');
  final Uri urlAviso = Uri.parse('https://fep.mx/aviso_de_privacidad');

  String version = '';
  String buildNumber = '';

  @override
  void onInit() {
    super.onInit();
    _getAppInfo();
  }

  Future<void> _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    update(); // Notifica a los widgets que escuchan este controlador sobre el cambio en el estado.
  }

  void launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrlString(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HankFooter extends StatelessWidget {
  final bool dark; // Nuevo parámetro

  HankFooter({super.key, required this.dark}); // Co

  final HankFooterController controller = Get.put(HankFooterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HankFooterController>(
      builder: (controller) {
        return Container(
          color: dark ? Colors.black : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image(
                  //   image: const AssetImage(
                  //       'assets/images/Icono_HANK_tablero_1024x1024_positivo.png'),
                  //   width: 30,
                  //   height: 30,
                  //   color: dark ? Colors.white : Colors.black54,
                  // ),
                  const SizedBox(width: 15),
                  Image(
                    image: const AssetImage('assets/images/icono_psd_blue.png'),
                    width: 20,
                    height: 20,
                    color: dark ? Colors.white : Colors.black54,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Text(
                      'Aviso de Privacidad ',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                    onTap: () => controller.launchUrl(controller.urlAviso),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    child: Text(
                      'Términos y Condiciones',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                    onTap: () => controller.launchUrl(controller.urlTerminos),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Text(
                  '© ${controller.year} HANK v${controller.version} (${controller.buildNumber})',
                  style: TextStyle(
                    color: dark ? Colors.white : Colors.black54,
                    fontSize: 10,
                  ),
                ),
                onTap: () => controller.launchUrl(controller.urlHank),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Derechos Reservados a',
                    style: TextStyle(
                      color: dark ? Colors.white : Colors.black54,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    child: Text(
                      'Posibilidades',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                    onTap: () =>
                        controller.launchUrl(controller.urlPosibilidades),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
