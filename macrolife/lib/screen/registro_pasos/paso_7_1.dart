import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_7_1(RegistroPasosController controller) {
  // return SizedBox(
  //   child: Obx(
  //     () {
  //       // Verifica si el objetivo es 'Aumentar'
  //       return Steep(
  //         enableScroll: false,
  //         isActivo: true.obs,
  //         title: '¿Cuál es tu objetivo de peso?',
  //         options: const [],
  //         body: SizedBox(
  //           height: 400,
  //           child: Column(
  //             // spacing: 5,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     controller.pesoDeseado.toString(),
  //                     style: TextStyle(
  //                       fontSize: 55,
  //                       letterSpacing: 3.5,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   Text(
  //                     ' KG',
  //                     style: TextStyle(
  //                       fontSize: 35,
  //                       letterSpacing: 3.5,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 40, bottom: 0),
  //                 child: SizedBox(
  //                   width: Get.width,
  //                   child: SimpleRulerPicker(
  //                     mostrar: true,
  //                     unitString: 'kg',
  //                     axis: Axis.horizontal,
  //                     minValue: 1,
  //                     currentWeight: controller.peso.value,
  //                     maxValue: 300,
  //                     initialValue: controller.pesoDeseado.value,
  //                     onValueChanged: (value) {
  //                       controller.pesoDeseado.value = value;
  //                       controller.ajustarLabelPeso();
  //                     },
  //                     scaleLabelSize: 16,
  //                     scaleBottomPadding: 20,
  //                     scaleItemWidth: 12,
  //                     longLineHeight: 50,
  //                     shortLineHeight: 14,
  //                     lineColor: Colors.grey,
  //                     selectedColor: Colors.black,
  //                     labelColor: Colors.black,
  //                     lineStroke: 2,
  //                     height: 200,
  //                   ),
  //                 ),
  //               ),
  //               Text(controller.pesoDeseadoLabel.value),
  //               Text(
  //                 controller.pesoDeseadoValue.value,
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //         onOptionSelected: (probado) {
  //           print(probado);
  //           controller.probado.value = probado;
  //         },
  //         selectedOption: controller.probado.value,
  //         onNext: controller.isProbadoSelected() ? controller.nextStep : null,
  //       );
  //     },
  //   ),
  // );

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: Text(
          '¿Cuál es tu objetivo de peso?',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.pesoDeseado.toString(),
            style: TextStyle(
              fontSize: 55,
              letterSpacing: 3.5,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Text(
              ' kg',
              style: TextStyle(
                fontSize: 35,
                letterSpacing: 3.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 0),
                    child: SizedBox(
                      width: Get.width,
                      child: SimpleRulerPicker(
                        mostrar: true,
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
                        height: 190,
                      ),
                    ),
                  ),
                  Text(
                    controller.pesoDeseadoLabel.value,
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.pesoDeseadoValue.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        ' kg',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 0, bottom: 30, left: 20, right: 20),
        child: buttonTest(
          'Siguiente',
          controller.isProbadoSelected() ? controller.nextStep : null,
          true,
        ),
      ),
    ],
  );
}
