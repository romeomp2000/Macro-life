import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_7_2(RegistroPasosController controller) {
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
            const Text(
              'Velocidad de pérdida de peso por semana',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${((controller.rapidoMeta * 10).truncateToDouble()) / 10} Kg',
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
                  'assets/icons/icono_tortuga_outline_200x98_activo.png',
                  color: Colors.black,
                  height: 25,
                ),
                Image.asset(
                  'assets/icons/icono_ardilla_outline_144x137_activo.png',
                  color: Colors.black,
                  height: 25,
                ),
                Image.asset(
                  'assets/icons/icono_gacela_outline_200x137_activo.png',
                  color: Colors.black,
                  height: 25,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: CupertinoSlider(
                min: 0.1,
                max: 1.5,
                thumbColor: Colors.black, // Color del círculo

                value: controller.rapidoMeta.value,
                onChanged: (meta) {
                  controller.rapidoMeta.value = meta;
                  FuncionesGlobales.vibratePress();
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                // ignore: unrelated_type_equality_checks
                controller.rapidoMeta == 0.1
                    ? 'Lento y constante'
                    : controller.rapidoMeta > 0.1 && controller.rapidoMeta < 1.5
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
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      ),
    ),
  );
}
