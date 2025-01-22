import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_6(RegistroPasosController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          '¿Cuál es tu peso?',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: SimpleRulerPicker(
                      unitString: 'kg',
                      axis: Axis.vertical,
                      widthScreen: Get.width,
                      isLeft: false,
                      minValue: 1,
                      maxValue: 300,
                      initialValue: controller.peso.value,
                      onValueChanged: (value) {
                        controller.peso.value = value;
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
                      height: (Get.height * 0.65) - 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 0, bottom: 30, left: 20, right: 20),
        child: buttonTest('Siguiente', controller.nextStep, true),
      ),
    ],
  );
}
