import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_4(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enablePadding: true,
        isActivo: true.obs,
        body: Column(
          spacing: 20,
          children: [
            Image.asset(
              'assets/icons/icono_circulo_estrella_217x217_activo.png',
              width: 65,
            ),
            GifView.asset(
              'assets/gifs/grafica_inicial_902x474.gif',
              width: Get.width - 50,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 30,
              fadeDuration: Duration(seconds: 1),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Text(
                'Según los datos de Macro Life, la pérdida de peso es un proceso integral basado en dieta, ejercicio y hábitos saludables.',
                textAlign: TextAlign.justify,
                style: TextStyle(
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
