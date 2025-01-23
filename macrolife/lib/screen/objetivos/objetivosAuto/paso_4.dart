import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_4(ObjetivosAutoController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isActivo: controller.isObjetivoPeso,
        title: '¿Cuál es tu objetivo?',
        description: 'Esto se utilizará para calibrar tu plan',
        options: [],
        body: Column(
          spacing: 20,
          children: [
            GeneroSelect(
              selected: controller.objetivo.value == 'Perder',
              onTap: () {
                controller.isObjetivoPeso.value = true;
                controller.objetivo.value = 'Perder';
                // controller.labelGraficaDoble.value =
                //     'Baja el doble de peso con Macro Life';
                controller.pesoDeseado.value = controller.peso.value - 5;
                controller.pesoDeseadoLabel.value = 'Bajar de peso';
                // controller.mostrarGrafica.value = true;
                controller.ajustarLabelPeso();
              },
              genero: 'Perder',
              icon: 'assets/icons/icono_bascula_157x57_bajo_activo.png',
            ),
            GeneroSelect(
              selected: controller.objetivo.value == 'Mantener',
              onTap: () {
                controller.isObjetivoPeso.value = true;
                controller.objetivo.value = 'Mantener';
                // controller.labelGraficaDoble.value = '';
                // controller.mostrarGrafica.value = false;
                controller.pesoDeseado.value = controller.peso.value;
                controller.pesoDeseadoLabel.value = 'Mantener de peso';
                controller.ajustarLabelPeso();
              },
              genero: 'Mantener',
              icon: 'assets/icons/icono_bascula_157x57_medio_activo.png',
            ),
            GeneroSelect(
              selected: controller.objetivo.value == 'Aumentar',
              onTap: () {
                controller.isObjetivoPeso.value = true;
                controller.objetivo.value = 'Aumentar';
                controller.pesoDeseado.value = controller.peso.value + 9;
                controller.pesoDeseadoLabel.value = 'Subir de peso';
                // controller.mostrarGrafica.value = true;
                controller.ajustarLabelPeso();

                // controller.labelGraficaDoble.value =
                //     'Gana el doble de peso con Macro Life';
              },
              genero: 'Aumentar',
              icon: 'assets/icons/icono_bascula_157x57_alto_activo.png',
            ),
            const SizedBox(height: 10)
          ],
        ),
        onOptionSelected: (objetivo) {
          controller.objetivo.value = objetivo;
          FuncionesGlobales.vibratePress();
          controller.ajustarLabelPeso();
        },
        selectedOption: controller.objetivo.value,
        onNext: controller.isObjetivoSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
