import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';

class RegistroController extends GetxController {
  final PageController pageControllerContent = PageController();
  final currentPage = 0.obs;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/imagen_foto_platillo_escaner_1125x1125_.jpg',
      'title': 'Simplifica tus calorías',
      'subtitle': 'Solo toma una foto rápida de tu comida',
    },
    // {
    //   'image': 'assets/images/imagen_foto_platillo_cuadros_1125x1125_6.jpg',
    //   'title': 'Mantén un control completo',
    //   'subtitle':
    //       'Lleva un seguimiento de tus nutrientes y calorías en cada comida',
    // },
    // {
    //   'image': 'assets/images/male-boxer-posing-t-shirt-with-arms-crossed.jpg',
    //   'title': 'Come saludablemente todos los días',
    //   'subtitle': 'Te ayudamos a mantener una dieta equilibrada y saludable',
    // },
  ];

  void updatePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    try {
      FuncionesGlobales.vibratePress();

      // if (currentPage.value < pages.length - 1) {
      //   if (pageControllerContent.hasClients) {
      //     // Verifica que el controlador esté listo
      //     pageControllerContent.nextPage(
      //       duration: const Duration(milliseconds: 300),
      //       curve: Curves.easeInOut,
      //     );
      //   }
      // } else {
      // pageControllerContent.jumpTo(0);
      // currentPage.value = 0;
      Get.offAndToNamed('/registro/pasos');
      // }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void onClose() {
    pageControllerContent
        .dispose(); // Dispose PageController to avoid memory leaks
    super.onClose();
  }
}
