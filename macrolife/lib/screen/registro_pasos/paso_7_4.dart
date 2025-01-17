import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_7_4(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.pesoDeseadoLabel.value == 'Subir de peso'
                      ? 'Ganar'
                      : 'Perder',
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.pesoDeseadoValue.value,
                      style: const TextStyle(
                        fontSize: 95,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        ' kg',
                        style: const TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  width: Get.width * 0.45,
                  child: Text(
                    'Es un objetivo realista. No es nada difícil.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 30),
                  width: Get.width * 0.65,
                  child: Text(
                    'El 90% de los usuarios informan de resultados notables después de usar Macro Life, con un progreso sostenido que es difícil de revertir.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                buttonTest('Siguiente', controller.nextStep, true)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
