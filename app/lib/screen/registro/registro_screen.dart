import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registro_controller.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistroController());

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo que ocupa la mitad superior y parece estar detrás del contenedor
          Positioned.fill(
            child: PageView.builder(
              controller: controller
                  .pageControllerImage, // Usar un controlador distinto para la imagen
              itemCount: controller.pages.length,
              onPageChanged: (index) {
                controller.currentPage.value = index;
              },
              itemBuilder: (context, index) {
                final page = controller.pages[index];
                return Image.network(
                  page['image']!,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  width: Get.width,
                );
              },
            ),
          ),
          // Contenedor inferior con contenido, botones y puntos de indicación
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 350),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título y subtítulo del contenido actual
                  Expanded(
                    child: PageView.builder(
                      controller: controller
                          .pageControllerContent, // Usar un controlador distinto para el contenido
                      itemCount: controller.pages.length,
                      onPageChanged: (value) =>
                          controller.currentPage.value = value,
                      itemBuilder: (context, index) {
                        final page = controller.pages[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              page['title']!,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              page['subtitle']!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Puntos de indicación de página
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentPage.value == index ? 12 : 8,
                          height:
                              controller.currentPage.value == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage.value == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Botón Siguiente
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
