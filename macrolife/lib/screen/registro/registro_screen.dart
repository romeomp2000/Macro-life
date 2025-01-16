import 'package:macrolife/screen/registro/registro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistroController());

    return Scaffold(
      body: Image.asset(
          controller.pages[controller.currentPage.value]['image']!,
          height: Get.height * 0.65,
          width: Get.width,
          fit: BoxFit.cover),
      bottomSheet: Container(
        height: Get.height * 0.4,
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 30,
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.07, bottom: 15),
                child: Column(
                  spacing: 15,
                  children: [
                    Text(
                      '${controller.pages[0]['title']}',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      controller.pages[0]['subtitle']!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              buttonTest('Siguiente', controller.nextPage, true),
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse(
                                'https://macrolife.app/terminos-y-condiciones/'),
                            mode: LaunchMode.externalApplication);
                      },
                      child: Text(
                        'Términos y condiciones',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse(
                                'https://macrolife.app/aviso-de-privacidad/'),
                            mode: LaunchMode.externalApplication);
                      },
                      child: Text(
                        'Aviso de privacidad',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
