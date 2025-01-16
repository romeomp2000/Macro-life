import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';

Widget paso_5_5(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isRuler: true,
        isActivo: true.obs,
        title: '¿Cuál es tu altura?',
        description: null,
        options: [],
        body: Container(
          width: Get.width,
          margin: EdgeInsets.only(
            top: 10,
          ),
          padding: EdgeInsets.only(bottom: 100),
          child: SimpleRulerPicker(
            unitString: 'cm',
            axis: Axis.vertical,
            minValue: 1,
            maxValue: 300,
            initialValue: controller.altura.value,
            onValueChanged: (value) {
              controller.altura.value = value;
            },
            scaleLabelSize: 16,
            scaleBottomPadding: 10,
            scaleItemWidth: 12,
            longLineHeight: 35,
            shortLineHeight: 14,
            lineColor: Colors.grey,
            selectedColor: Colors.black,
            labelColor: Colors.black,
            lineStroke: 1,
            height: Get.height - 240,
          ),
        ),
        onOptionSelected: (gender) {},
        onNext: controller.nextStep,
      ),
    ),
  );
}
