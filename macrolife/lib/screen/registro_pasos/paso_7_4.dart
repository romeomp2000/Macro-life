import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_7_4(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: false,
        enablePadding: true,
        isActivo: true.obs,
        body: Center(
          child: SizedBox(
            // height: Get.height - 230,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 30,
              children: [
                Text(
                  controller.objetivo.value == 'Aumentar'
                      ? 'Ganando'
                      : 'Perdiendo',
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.pesoDeseadoValue.value,
                  style: const TextStyle(
                    fontSize: 60,
                  ),
                ),
                Text(
                  'Es un objetivo realista.\nNo es nada difícil.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 30),
                // e
                // Spacer(),
                Text(
                  'El 90% de los usuarios informan de resultados notables después de usar Macro Life, con un progreso sostenido que es difícil de revertir.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      // fontSize: 20,
                      ),
                )
              ],
            ),
          ),
        ),
        title: '',
        options: [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      ),
    ),
  );
}
