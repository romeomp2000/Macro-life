import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'controller.dart';

class PesoObjetivosScreen extends StatelessWidget {
  const PesoObjetivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PesoObjetivoController controller = Get.put(PesoObjetivoController());
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
        title: const Text(
          'Editar objetivo de peso',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${controller.pesoObjetivo.toInt()}',
                        style: TextStyle(
                          fontSize: 55,
                          letterSpacing: 3.5,
                          color: Colors.black,
                        ),
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
                SizedBox(
                  width: Get.width,
                  child: Obx(
                    () => SimpleRulerPicker(
                      mostrar: true,
                      unitString: 'kg',
                      axis: Axis.horizontal,
                      minValue: 1,
                      currentWeight: controller.pesoActual.value,
                      maxValue: 300,
                      initialValue: controller.pesoObjetivo.value,
                      onValueChanged: (value) {
                        controller.pesoObjetivo.value = value;
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
              ],
            ),
          ),
          Container(
            width: Get.width - 20,
            margin: EdgeInsets.only(bottom: GetPlatform.isIOS ? 20 : 0),
            child: CustomElevatedButton(
              function: () => {controller.guardaObjetivoPeso()},
              message: 'Hecho',
            ),
          ),
        ],
      ),
    );
  }
}
