import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/models/ingrediente.model.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/objetivos/controller.dart';

class IngredientesEditarController extends GetxController {
  final Rx<IngredienteModel> ingrediente = IngredienteModel().obs;
  final WeeklyCalendarController controllerCalendario = Get.find();

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
  var chartData = <ChartData>[].obs;

  void eliminarIngrediente() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'alimentos/eliminar-ingrediente/${ingrediente.value.id}',
        method: Method.DELETE,
      );

      print(response);
      final AlimentoModel alimentoResponse =
          AlimentoModel.fromJson(response['alimento']);

      final IngredienteModel ingredienteResponse =
          IngredienteModel.fromJson(response['ingrediente']);

      Get.back(result: {
        'alimento': alimentoResponse,
        'ingrediente': ingredienteResponse,
      });

      controllerCalendario.cargaAlimentos();
    } catch (e) {
      print(e);
    }
  }

  Future editarIngrediente() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'alimentos/ingrediente/',
        method: Method.PUT,
        body: {
          'id': ingrediente.value.id,
          'calorias': double.parse(calorias.text),
          'proteina': double.parse(protinae.text),
          'carbohidratos': double.parse(carbohidratos.text),
          'grasas': double.parse(grasas.text),
        },
      );

      final AlimentoModel alimentoResponse =
          AlimentoModel.fromJson(response['alimento']);

      final IngredienteModel ingredienteResponse =
          IngredienteModel.fromJson(response['ingrediente']);

      Get.back(result: {
        'alimento': alimentoResponse,
        'ingrediente': ingredienteResponse,
      });

      controllerCalendario.cargaAlimentos();
    } catch (e) {
      print(e);
    }
  }
}
