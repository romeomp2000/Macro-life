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
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    controller.pages[0]['subtitle']!,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // CustomElevatedButton(
            //   function: controller.nextPage,
            //   message: 'Siguiente',
            // ),
            buttonTest('Siguiente', controller.nextPage, true),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 40),
              child: Row(
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
            )
          ],
        ),
      ),
    );
  }
}



      //     //           // Obx(
      //     //           //   () => Row(
      //     //           //     mainAxisAlignment: MainAxisAlignment.center,
      //     //           //     spacing: 8,
      //     //           //     children: List.generate(
      //     //           //       controller.pages.length,
      //     //           //       (index) => Container(
      //     //           //         width:
      //     //           //             controller.currentPage.value == index ? 12 : 8,
      //     //           //         height:
      //     //           //             controller.currentPage.value == index ? 12 : 8,
      //     //           //         decoration: BoxDecoration(
      //     //           //           shape: BoxShape.circle,
      //     //           //           color: controller.currentPage.value == index
      //     //           //               ? Colors.black
      //     //           //               : Colors.black12,
      //     //           //         ),
      //     //           //       ),
      //     //           //     ),
      //     //           //   ),
      //     //           // ),

      //     //           Container(
      //     //             margin:
      //     //                 EdgeInsets.only(top: Get.height * 0.07, bottom: 15),
      //     //             child: Column(
      //     //               spacing: 15,
      //     //               children: [
      //     //                 Text(
      //     //                   '${controller.pages[0]['title']}',
      //     //                   maxLines: 1,
      //     //                   style: const TextStyle(
      //     //                     fontSize: 25,
      //     //                     fontWeight: FontWeight.bold,
      //     //                   ),
      //     //                   overflow: TextOverflow.ellipsis,
      //     //                   textAlign: TextAlign.center,
      //     //                 ),
      //     //                 Text(
      //     //                   controller.pages[0]['subtitle']!,
      //     //                   textAlign: TextAlign.center,
      //     //                 ),
      //     //               ],
      //     //             ),
      //     //           ),
      //     //           CustomElevatedButton(
      //     //             function: controller.nextPage,
      //     //             message: 'Siguiente',
      //     //           ),
      //     //           // ElevatedButton(
      //     //           //   onPressed: () {
      //     //           //     // print('object');
      //     //           //     controller.nextPage();
      //     //           //   },
      //     //           //   style: ElevatedButton.styleFrom(
      //     //           //     backgroundColor: Colors.black,
      //     //           //     shape: RoundedRectangleBorder(
      //     //           //       borderRadius: BorderRadius.circular(30),
      //     //           //     ),
      //     //           //     minimumSize: const Size.fromHeight(50),
      //     //           //   ),
      //     //           //   child: const Text(
      //     //           //     'Siguiente',
      //     //           //     style: TextStyle(fontSize: 18, color: Colors.white),
      //     //           //   ),
      //     //           // ),

      //     //           Container(
      //     //             // padding: const EdgeInsets.all(20),
      //     //             margin:
      //     //                 const EdgeInsets.only(left: 0, right: 0, bottom: 10),
      //     //             child: Row(
      //     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     //               children: [
      //     //                 GestureDetector(
      //     //                   onTap: () {
      //     //                     launchUrl(
      //     //                         Uri.parse(
      //     //                             'https://macrolife.app/terminos-y-condiciones/'),
      //     //                         mode: LaunchMode.externalApplication);
      //     //                   },
      //     //                   child: Text(
      //     //                     'Términos y condiciones',
      //     //                     style: TextStyle(fontWeight: FontWeight.w600),
      //     //                   ),
      //     //                 ),
      //     //                 GestureDetector(
      //     //                   onTap: () {
      //     //                     launchUrl(
      //     //                         Uri.parse(
      //     //                             'https://macrolife.app/aviso-de-privacidad/'),
      //     //                         mode: LaunchMode.externalApplication);
      //     //                   },
      //     //                   child: Text(
      //     //                     'Aviso de privacidad',
      //     //                     style: TextStyle(fontWeight: FontWeight.w600),
      //     //                   ),
      //     //                 )
      //     //               ],
      //     //             ),
      //     //           ),
      //     //         ],
      //     //       ),
      //     //     );
      //     //   },
      //     // ),
      //   ],
      // ),
    