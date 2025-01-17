import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_6(RegistroPasosController controller) {
  // return SizedBox(
  //   child: Obx(
  //     () => Steep(
  //       enableScroll: true,
  //       isActivo: true.obs,
  //       isBascula: true,
  //       title: '¿Cuál es tu peso?',
  //       description: '',
  //       options: [],
  //       body: SizedBox(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Container(
  //               margin: EdgeInsets.only(bottom: Get.height * 0.27),
  //               // child: Text(
  //               //   '¿Cual es tu peso?',
  //               //   textAlign: TextAlign.center,
  //               //   style: TextStyle(
  //               //     fontSize: 25,
  //               //     fontWeight: FontWeight.bold,
  //               //   ),
  //               // ),
  //             ),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   '${controller.peso.value}',
  //                   style: TextStyle(
  //                     fontSize: 55,
  //                     letterSpacing: 3.5,
  //                   ),
  //                 ),
  //                 Text(
  //                   ' kg',
  //                   style: TextStyle(
  //                     fontSize: 35,
  //                     letterSpacing: 3.5,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               child: AnimatedWeightPicker(
  //                 initialValue: controller.peso.value != 70.0
  //                     ? controller.peso.value.toDouble()
  //                     : 70.0,
  //                 showSelectedValue: false,
  //                 subIntervalTextSize: 20,
  //                 majorIntervalTextSize: 11,
  //                 minorIntervalTextSize: 10,
  //                 dialColor: Colors.red,
  //                 dialThickness: 4,
  //                 dialHeight: 75,
  //                 subIntervalHeight: 25,
  //                 majorIntervalHeight: 35,
  //                 minorIntervalHeight: 25,
  //                 showSuffix: true,
  //                 majorIntervalTextColor: Colors.black,
  //                 suffixTextColor: Colors.black,
  //                 // subIntervalColor: Colors.black,
  //                 majorIntervalColor: Colors.black,
  //                 selectedValueColor: Colors.black,
  //                 subIntervalTextColor: Colors.black,
  //                 minorIntervalTextColor: Colors.black,
  //                 minorIntervalColor: Colors.black26,
  //                 min: 0,
  //                 division: 1,
  //                 max: 300,
  //                 onChange: (newValue) {
  //                   debugPrint('Nuevo valor seleccionado: $newValue');
  //                   controller.peso.value = int.parse(newValue);
  //                   controller.pesoDeseado.value = int.parse(newValue);
  //                   controller.pesoDeseadoLabel.value = 'Mantener de peso';
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
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
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text(
            //       '${controller.peso.value}',
            //       style: TextStyle(
            //         fontSize: 55,
            //         letterSpacing: 3.5,
            //       ),
            //     ),
            //     Text(
            //       ' kg',
            //       style: TextStyle(
            //         fontSize: 35,
            //         letterSpacing: 3.5,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   child: AnimatedWeightPicker(
            //     initialValue: controller.peso.value != 70.0
            //         ? controller.peso.value.toDouble()
            //         : 70.0,
            //     showSelectedValue: false,
            //     subIntervalTextSize: 20,
            //     majorIntervalTextSize: 11,
            //     minorIntervalTextSize: 10,
            //     dialColor: Colors.red,
            //     dialThickness: 4,
            //     dialHeight: 75,
            //     subIntervalHeight: 25,
            //     majorIntervalHeight: 35,
            //     minorIntervalHeight: 25,
            //     showSuffix: true,
            //     majorIntervalTextColor: Colors.black,
            //     suffixTextColor: Color.fromARGB(255, 193, 193, 193),
            //     majorIntervalColor: Colors.black,
            //     selectedValueColor: Color.fromARGB(255, 193, 193, 193),
            //     subIntervalTextColor: Color.fromARGB(255, 193, 193, 193),
            //     minorIntervalTextColor: Color.fromARGB(255, 193, 193, 193),
            //     minorIntervalColor: Color.fromARGB(255, 193, 193, 193),
            //     min: 0,
            //     division: 1,
            //     max: 300,
            //     onChange: (newValue) {
            //       debugPrint('Nuevo valor seleccionado: $newValue');
            //       controller.peso.value = int.parse(newValue);
            //       controller.pesoDeseado.value = int.parse(newValue);
            //       controller.pesoDeseadoLabel.value = 'Mantener de peso';
            //     },
            //   ),
            // ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width,
                    // height: Get.height * 0.62,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: SimpleRulerPicker(
                      unitString: 'kg',
                      axis: Axis.vertical,
                      isLeft: false,
                      minValue: 1,
                      maxValue: 300,
                      initialValue: controller.peso.value,
                      // currentWeight: controller.peso.value,
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
