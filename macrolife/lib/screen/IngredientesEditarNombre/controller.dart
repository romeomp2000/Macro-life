import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IngredientesEditarNombreController extends GetxController {
  final nameController = TextEditingController();
  final id = ''.obs;

  final WeeklyCalendarController controllerCalendario = Get.find();

  void actualizarNombreAlimento() async {
    Get.back(result: nameController.text);
    final apiService = ApiService();

    await apiService.fetchData(
      'alimentos/nombre',
      method: Method.PUT,
      body: {
        'id': id.value,
        'nombre': nameController.text,
      },
    );

    controllerCalendario.cargaAlimentos();
  }
}
