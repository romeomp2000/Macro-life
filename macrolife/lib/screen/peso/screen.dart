import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'controller.dart';

class PesoActualizarScreen extends StatelessWidget {
  const PesoActualizarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> pesos = List<int>.generate(341, (i) => 20 + i);

    PesoObjetivoController controller = Get.put(PesoObjetivoController());

    // Obtener el índice inicial correspondiente al peso actual del usuario
    final initialIndex = pesos.indexOf(controller.peso.value);

    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialIndex);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text('Establecer peso'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Obx(
                //   () => Text(
                //     '${controller.peso.toInt()} kg',
                //     style: const TextStyle(
                //       fontSize: 40,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: SimpleRulerPicker(
                    unitString: 'kg',
                    axis: Axis.vertical,
                    isLeft: false,
                    minValue: 1,
                    maxValue: 300,
                    initialValue: controller.peso.value,
                    onValueChanged: (value) {
                      controller.peso.value = value;
                    },
                    widthScreen: Get.width,
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Expanded(
                //               child: Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   const Text(
                //                     'Peso',
                //                     style: TextStyle(
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.bold,
                //                     ), // Texto en negritas
                //                   ),
                //                   SizedBox(
                //                     height: 180,
                //                     child: CupertinoPicker(
                //                       itemExtent: 32.0,
                //                       scrollController: scrollController,
                //                       onSelectedItemChanged: (int index) {
                //                         controller.peso.value = pesos[index];
                //                       },
                //                       children: pesos.map((peso) {
                //                         return Center(
                //                             child: Text('$peso kg'));
                //                       }).toList(),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            width: Get.width - 20,
            margin: EdgeInsets.only(bottom: GetPlatform.isIOS ? 20 : 0),
            child: CustomElevatedButton(
              function: () => {controller.guardaPeso()},
              message: 'Hecho',
            ),
          ),
        ],
      ),
    );
  }
}
