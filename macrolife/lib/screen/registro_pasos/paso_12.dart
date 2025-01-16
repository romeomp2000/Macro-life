import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_12(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () {
        controller.calificarApp();

        return Steep(
          enablePadding: true,
          isActivo: true.obs,
          title: 'Danos tu opinión',
          description: '¿Está satisfecho con nuestra aplicación?',
          options: const [],
          body: Scrollable(
            axisDirection: AxisDirection.down,
            viewportBuilder: (context, offset) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 246, 246, 246)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.black, size: 40),
                        Icon(Icons.star, color: Colors.black, size: 40),
                        Icon(Icons.star, color: Colors.black, size: 40),
                        Icon(Icons.star, color: Colors.black, size: 40),
                        Icon(Icons.star, color: Colors.black, size: 40),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          onOptionSelected: (entrenamiento) =>
              controller.entrenamiento.value = entrenamiento,
          selectedOption: controller.entrenamiento.value,
          onNext: controller.nextStep,
          enableScroll: true,
        );
      },
    ),
  );
}
