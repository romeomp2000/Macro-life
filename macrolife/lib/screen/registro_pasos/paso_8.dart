import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_8(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enablePadding: false,
        enableScroll: true,
        isActivo: true.obs,
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
              'assets/gifs/grafica_dieta_mes_952x780.gif',
              width: Get.width - 50,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 30,
              fadeDuration: Duration(seconds: 1),
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
