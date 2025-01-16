import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_7_3(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(() {
      GifController controllerGif = GifController();
      return Steep(
        enableScroll: true,
        enablePadding: true,
        isActivo: true.obs,
        body: Column(
          spacing: 60,
          children: [
            GifView.asset(
              'assets/gifs/animacion_barras_comparativas_658x984.gif',
              height: 250,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 20,
              imageRepeat: ImageRepeat.repeatY,
              fadeDuration: Duration(seconds: 1),
              controller: controllerGif,
              onFrame: (frame) {
                if (frame == 13) {
                  controllerGif.pause();
                }
                return;
                // print(frame);
              },
            ),
            Text(
              'Macro Life lo hace fácil y te hace responsable',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        title: controller.labelGraficaDoble.value,
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      );
    }),
  );
}
