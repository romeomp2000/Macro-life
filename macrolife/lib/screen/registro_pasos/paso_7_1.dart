import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';

Widget paso_7_1(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () {
        // Verifica si el objetivo es 'Aumentar'
        return Steep(
          enableScroll: false,
          isActivo: true.obs,
          title: '¿Cuál es tu objetivo de peso?',
          options: const [],
          body: SizedBox(
            height: 270,
            child: Column(
              spacing: 15,
              children: [
                // Otros widgets dentro del Column
                SizedBox(
                  width: Get.width,
                  child: SimpleRulerPicker(
                    unitString: 'kg',
                    axis: Axis.horizontal,
                    minValue: 1,
                    currentWeight: controller.peso.value,
                    maxValue: 300,
                    initialValue: controller.pesoDeseado.value,
                    onValueChanged: (value) {
                      controller.pesoDeseado.value = value;
                      controller.ajustarLabelPeso();
                    },
                    scaleLabelSize: 16,
                    scaleBottomPadding: 20,
                    scaleItemWidth: 12,
                    longLineHeight: 50,
                    shortLineHeight: 14,
                    lineColor: Colors.grey,
                    selectedColor: Colors.black,
                    labelColor: Colors.black,
                    lineStroke: 2,
                    height: 200,
                  ),
                ),
                Text(controller.pesoDeseadoLabel.value),
                Text(
                  controller.pesoDeseadoValue.value,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          onOptionSelected: (probado) {
            controller.probado.value = probado;
          },
          selectedOption: controller.probado.value,
          onNext: controller.isProbadoSelected() ? controller.nextStep : null,
        );
      },
    ),
  );
}
