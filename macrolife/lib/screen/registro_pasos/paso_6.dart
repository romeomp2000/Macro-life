import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/AnimatedWeightPicker.dart';

Widget paso_6(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isActivo: true.obs,
        isBascula: true,
        title: '',
        description: '',
        options: [],
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.27),
                child: Text(
                  '¿Cual es tu peso?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.peso.value}',
                    style: TextStyle(
                      fontSize: 55,
                      letterSpacing: 3.5,
                    ),
                  ),
                  Text(
                    ' kg',
                    style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 3.5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: AnimatedWeightPicker(
                  initialValue: controller.peso.value != 70.0
                      ? controller.peso.value.toDouble()
                      : 70.0,
                  showSelectedValue: false,
                  subIntervalTextSize: 20,
                  majorIntervalTextSize: 11,
                  minorIntervalTextSize: 10,
                  dialColor: Colors.red,
                  dialThickness: 4,
                  dialHeight: 75,
                  subIntervalHeight: 25,
                  majorIntervalHeight: 35,
                  minorIntervalHeight: 25,
                  showSuffix: true,
                  majorIntervalTextColor: Colors.black,
                  suffixTextColor: Colors.black,
                  // subIntervalColor: Colors.black,
                  majorIntervalColor: Colors.black,
                  selectedValueColor: Colors.black,
                  subIntervalTextColor: Colors.black,
                  minorIntervalTextColor: Colors.black,
                  minorIntervalColor: Colors.black26,
                  min: 0,
                  division: 1,
                  max: 300,
                  onChange: (newValue) {
                    debugPrint('Nuevo valor seleccionado: $newValue');
                    controller.peso.value = int.parse(newValue);
                    controller.pesoDeseado.value = int.parse(newValue);
                    controller.pesoDeseadoLabel.value = 'Mantener de peso';
                  },
                ),
              ),
            ],
          ),
        ),
        onOptionSelected: (gender) {},
        onNext: controller.nextStep,
      ),
    ),
  );
}
