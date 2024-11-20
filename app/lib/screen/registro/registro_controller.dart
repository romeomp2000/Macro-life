import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroController extends GetxController {
  final PageController pageControllerImage = PageController();
  final PageController pageControllerContent =
      PageController(); // Nuevo controlador
  final currentPage = 0.obs;

  final List<Map<String, String>> pages = [
    {
      'image':
          'https://www.calai.app/_astro/feature_image1.DSQBy9Wl_2sc1C4.png',
      'title': 'El seguimiento de calorías hecho fácil',
      'subtitle':
          'Solo toma una foto rápida de tu comida y nosotros haremos el resto',
    },
    {
      'image':
          'https://www.calai.app/_astro/feature_image1.DSQBy9Wl_2sc1C4.png',
      'title': 'Mantén un control completo',
      'subtitle':
          'Lleva un seguimiento de tus nutrientes y calorías en cada comida',
    },
    {
      'image':
          'https://www.calai.app/_astro/feature_image1.DSQBy9Wl_2sc1C4.png',
      'title': 'Come saludablemente todos los días',
      'subtitle': 'Te ayudamos a mantener una dieta equilibrada y saludable',
    },
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageControllerContent.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      pageControllerImage.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Lógica para el final de las páginas
      Get.toNamed('/registro/pasos');
    }
  }

  @override
  void onInit() {
    super.onInit();
    pageControllerImage.addListener(() {
      currentPage.value = pageControllerImage.page!.round();
    });
  }

  @override
  void onClose() {
    pageControllerImage.dispose();
    pageControllerContent.dispose();
    super.onClose();
  }
}
