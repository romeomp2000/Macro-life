import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_15(RegistroPasosController controller) {
  return SizedBox(
    child: Builder(builder: (context) {
      controller.connectAppleHealth();

      return Steep(
        enablePadding: true,
        isActivo: true.obs,
        enableScroll: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Image.asset(
              'assets/images/imagen_health_1125x1125_original (1).png',
              width: Get.width - 50,
            ),
            Text(
              'Macro Life realiza un seguimiento de tus ascensos y ajusta tus objetivos en consecuencia.',
              textAlign: TextAlign.center,
            )
          ],
        ),
        enabledButtonSaltar: true,
        title: 'Conectar con Apple Health',
        description:
            'Puedes cambiarlo en cualquier momento en la configuración',
        options: const [],
        selectedOption: controller.codigoController.value.text,
        onNext: controller.nextStep,
      );
    }),
  );
}
