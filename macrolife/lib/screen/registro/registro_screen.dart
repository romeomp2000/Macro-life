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
      body: Stack(
        children: [
          Obx(
            () => Image.asset(
              controller.pages[controller.currentPage.value]['image']!,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              height: Get.height * 0.64,
              width: Get.width,
            ),
          ),
          DraggableScrollableSheet(
            snap: false,
            minChildSize: 0.42,
            maxChildSize: 0.42,
            initialChildSize: 0.42,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    // Título y subtítulo del contenido actual
                    Expanded(
                      child: PageView.builder(
                        controller: controller.pageControllerContent,
                        itemCount: controller.pages.length,
                        onPageChanged: controller.updatePage,
                        itemBuilder: (context, index) {
                          final page = controller.pages[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                page['title']!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                page['subtitle']!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: List.generate(
                          controller.pages.length,
                          (index) => Container(
                            width:
                                controller.currentPage.value == index ? 12 : 8,
                            height:
                                controller.currentPage.value == index ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),
                          ),
                        ),
                      ),
                    ),

                    CustomElevatedButton(
                      function: controller.nextPage,
                      message: 'Siguiente',
                    ),
                    // ElevatedButton(
                    //   onPressed: controller.nextPage,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.black,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //     minimumSize: const Size.fromHeight(50),
                    //   ),
                    //   child: const Text(
                    //     'Siguiente',
                    //     style: TextStyle(fontSize: 18, color: Colors.white),
                    //   ),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            style: TextStyle(fontWeight: FontWeight.w600),
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
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
