import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObjetivosController extends GetxController {
  RxBool showKeyboardActions = false.obs;

  // Método para alternar la visibilidad
  void toggleKeyboardActions(bool isVisible) {
    showKeyboardActions.value = isVisible;
  }

  final calorias = TextEditingController();
  final protinae = TextEditingController();
  final carbohidratos = TextEditingController();
  final grasas = TextEditingController();

  // Datos del gráfico
  var chartData = <ChartData>[
    // ChartData('Proteínas', 100, Colors.redAccent),
    // ChartData('Grasas', 108, Color(0xFFE69938)),
    // ChartData('Carbohidratos', 35, Colors.blueAccent),
  ].obs;

  // Método para actualizar datos (ejemplo dinámico)
  void updateChartData() {
    chartData[0] =
        ChartData('Proteínas', 150, Colors.redAccent); // Actualiza Proteínas
    chartData[1] =
        ChartData('Grasas', 90, const Color(0xFFE69938)); // Actualiza Grasas
    chartData[2] = ChartData(
        'Carbohidratos', 50, Colors.blueAccent); // Actualiza Carbohidratos
    chartData.refresh(); // Notifica a los listeners
  }

  var calorieController = TextEditingController(text: '1,292').obs;
  var proteinController = TextEditingController(text: '134').obs;

  // FocusNode para controlar el foco de los campos
  var calorieFocusNode = FocusNode().obs;
  var proteinFocusNode = FocusNode().obs;

  void back() {
    Get.back();
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}
