import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_8(RegistroPasosController controller) {
  GifController controllerGif = GifController();
  return SizedBox(
    child: Obx(
      () => Steep(
        enablePadding: false,
        enableScroll: true,
        isActivo: controller.isGrafica3,
        body: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'El 80% de los usuarios de Macro Life mantienen su peso ideal incluso 6 meses después',
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Tu peso',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GifView.asset(
              'assets/gifs/animacion_grafica_02_test_952x780.gif',
              width: Get.width - 50,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 30,
              controller: controllerGif,
              fadeDuration: Duration(seconds: 0),
              onFrame: (frame) {
                // print(frame);
                if (frame == 59) {
                  controllerGif.pause();
                  controller.isGrafica3.value = true;
                }
                return;
              },
            ),
          ],
        ),
        title: 'Crea resultados a largo plazo',
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      ),
    ),
  );
}
