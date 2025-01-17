import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_4(RegistroPasosController controller) {
  GifController gifController = GifController();
  return SizedBox(
    child: Obx(
      () => Steep(
        enablePadding: true,
        enableScroll: true,
        isActivo: controller.isGrafica1,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset(
              'assets/icons/icono_circulo_estrella_217x217_activo.png',
              width: 80,
            ),
            GifView.asset(
              'assets/gifs/animacion_grafica_01_test_902x474.gif',
              width: Get.width - 50,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 30,
              controller: gifController,
              fadeDuration: Duration(seconds: 1),
              onFrame: (frame) {
                if (frame == 60) {
                  gifController.pause();
                  controller.isGrafica1.value = true;
                }
                return;
                // print(frame);
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 100, left: 30, right: 30, bottom: 10),
              child: Text(
                'Según los datos de Macro Life, la pérdida de peso es un proceso integral basado en dieta, ejercicio y hábitos saludables.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        title: 'Tienes un gran potencial para alcanzar tu objetivo',
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      ),
    ),
  );
}
