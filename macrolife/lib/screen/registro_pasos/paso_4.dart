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
        enableScroll: true,
        isActivo: true.obs,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/icono_circulo_estrella_217x217_activo.png',
              width: 80,
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
              margin: const EdgeInsets.only(
                top: 70,
                left: 30,
                right: 30,
              ),
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
