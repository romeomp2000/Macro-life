import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_6(ObjetivosAutoController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: false,
        isActivo: true.obs,
        enablePadding: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.pesoDeseadoLabel.value != 'Subir de peso'
                    ? 'Velocidad de pérdida de peso por semana'
                    : 'Velocidad para ganar peso por semana',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${((controller.rapidoMeta * 10).truncateToDouble()) / 10} kg',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/icono_velocidad_perdida_peso_146x146_tortuga_activo.png',
                  color: controller.rapidoMeta == 0.1 ||
                          controller.rapidoMeta > 0.1 &&
                              controller.rapidoMeta < 0.3
                      ? Colors.black
                      : Color.fromARGB(255, 193, 193, 193),
                  height: controller.rapidoMeta == 0.1 ||
                          controller.rapidoMeta > 0.1 &&
                              controller.rapidoMeta < 0.3
                      ? 50
                      : 45,
                ),
                Image.asset(
                  'assets/icons/icono_velocidad_perdida_peso_146x146_ardilla_activo.png',
                  color:
                      controller.rapidoMeta > 0.3 && controller.rapidoMeta < 1.3
                          ? Colors.black
                          : Color.fromARGB(255, 193, 193, 193),
                  height:
                      controller.rapidoMeta > 0.3 && controller.rapidoMeta < 1.3
                          ? 50
                          : 45,
                ),
                Image.asset(
                  'assets/icons/icono_velocidad_perdida_peso_146x146_gacela_activo.png',
                  color: controller.rapidoMeta > 1.3
                      ? Colors.black
                      : Color.fromARGB(255, 193, 193, 193),
                  height: controller.rapidoMeta > 1.3 ? 50 : 45,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: CupertinoSlider(
                min: 0.1,
                max: 1.5,
                thumbColor: Colors.black,
                value: controller.rapidoMeta.value,
                onChanged: (meta) {
                  controller.rapidoMeta.value = meta;
                  double valor =
                      ((controller.rapidoMeta.value * 10).truncateToDouble()) /
                          10;

                  if (valor != controller.lastValorRapidoMeta.value) {
                    FuncionesGlobales.vibratePressLow();
                    controller.lastValorRapidoMeta.value = valor;
                  }
                },
              ),
            ),
            // const SizedBox(height: 20),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 248, 248, 248),
                  width: 2.5,
                ),
              ),
              child: Text(
                // ignore: unrelated_type_equality_checks
                (controller.rapidoMeta == 0.1 ||
                        controller.rapidoMeta > 0.1 &&
                            controller.rapidoMeta < 0.3)
                    ? 'Lento y constante'
                    : controller.rapidoMeta > 0.3 && controller.rapidoMeta < 1.3
                        ? 'Recomendado'
                        : 'Puede sentirse muy cansado',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        title: '¿Qué tan rápido quieres alcanzar tu meta?',
        options: const [],
        onOptionSelected: (probado) {},
        selectedOption: null,
        onNext: () async {
          await controller.actualizarDatos();
        },
      ),
    ),
  );
}
