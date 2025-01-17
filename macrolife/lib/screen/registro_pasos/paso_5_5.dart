import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_5_5(RegistroPasosController controller) {
  // return SizedBox(
  //   child: Obx(
  //     () =>
  //     Steep(
  //       enableScroll: true,
  //       isRuler: true,
  //       isActivo: true.obs,
  //       title: '¿Cuál es tu altura?',
  //       description: null,
  //       options: [],
  //       body: Column(
  //         children: [
  //           Container(
  //             width: Get.width,
  //             margin: EdgeInsets.only(
  //               top: 10,
  //             ),
  //             child: SimpleRulerPicker(
  //               unitString: 'cm',
  //               axis: Axis.vertical,
  //               minValue: 1,
  //               maxValue: 300,
  //               initialValue: controller.altura.value,
  //               onValueChanged: (value) {
  //                 controller.altura.value = value;
  //               },
  //               scaleLabelSize: 16,
  //               scaleBottomPadding: 10,
  //               scaleItemWidth: 12,
  //               longLineHeight: 35,
  //               shortLineHeight: 14,
  //               lineColor: Colors.grey,
  //               selectedColor: Colors.black,
  //               labelColor: Colors.black,
  //               lineStroke: 1,
  //               height: Get.height - 240,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 200,
  //           )
  //         ],
  //       ),
  //       onOptionSelected: (gender) {},
  //       onNext: controller.nextStep,
  //     ),

  //   ),
  // );

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          '¿Cuál es tu altura?',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              // height: Get.height * 0.62,
              margin: EdgeInsets.only(top: 10, bottom: 20),
              child: SimpleRulerPicker(
                unitString: 'cm',
                axis: Axis.vertical,
                minValue: 50,
                maxValue: 250,
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
                height: Get.height * 0.65,
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
