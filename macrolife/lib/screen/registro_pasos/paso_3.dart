import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_3(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        title: '¿Has probado otras apps de seguimiento de calorías?',
        options: [],
        isActivo: controller.isOtraApp,
        enableScroll: true,
        body: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: GeneroSelect(
                selected: controller.probado.value == 'Si',
                onTap: () {
                  controller.isOtraApp.value = true;
                  controller.probado.value = 'Si';
                },
                genero: 'Si',
                icon: 'assets/icons/icono_like_137x137_01_activo.png',
              ),
            ),
            GeneroSelect(
              selected: controller.probado.value == 'No',
              onTap: () {
                controller.isOtraApp.value = true;
                controller.probado.value = 'No';
              },
              genero: 'No',
              icon: 'assets/icons/icono_like_137x137_02_activo.png',
            ),
          ],
        ),
        onOptionSelected: (probado) {
          controller.probado.value = probado;
          FuncionesGlobales.vibratePress();
        },
        selectedOption: controller.probado.value,
        onNext: controller.isProbadoSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
