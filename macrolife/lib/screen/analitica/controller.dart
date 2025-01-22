import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/analiticaNutricion.model.dart';
import 'package:macrolife/screen/objetivos/controller.dart';

class AnaliticaController extends GetxController {
  final RxList<ChartData> charSorce = <ChartData>[].obs;
  final Rx<AnaliticaNutricionModel> analiticaNutricion =
      AnaliticaNutricionModel().obs;
  final apiService = ApiService();
  UsuarioController usuarioController = Get.find();

  final List<String> listaNutricion = [
    'Esta semana',
    'La semana pasada',
    'Hace 2 semanas',
    'Hace 3 semanas'
  ];

  final tipoBusquedaNutricion = 'Esta semana'.obs;
  final List<String> listaProgreso = [
    '90 Días',
    '6 Meses',
    '1 Año',
    'Todo el tiempo'
  ];

  final tipoBusquedaProgreso = '90 Días'.obs;

  final color = Colors.transparent.obs;
  final isLoading = false.obs;

  var chartData = <ChartDataP>[].obs;
  var chartAxis = ChartAxis(minimo: 0, maximo: 100).obs;

  Future<void> fetchPesoHistorial() async {
    isLoading.value = true;
    try {
      final response = await apiService.fetchData(
        'analitica/peso',
        method: Method.POST,
        body: {
          'idUsuario': usuarioController.usuario.value.sId,
          'tipoBusqueda': tipoBusquedaProgreso.value,
        },
      );

      // Mapear los datos de la respuesta
      final List<ChartDataP> fetchedData = (response['data'] as List)
          .map((item) => ChartDataP.fromJson(item))
          .toList();

      final ChartAxis fetchedAxis = ChartAxis.fromJson(response['ejeY']);

      // Actualizar los observables
      chartData.value = fetchedData;
      chartAxis.value = fetchedAxis;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo obtener el historial de peso');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNutricion() async {
    try {
      isLoading(true);

      charSorce.clear(); // Limpiar datos anteriores

      final response = await apiService.fetchData(
        'analitica/nutricion',
        method: Method.POST,
        body: {
          'idUsuario': usuarioController.usuario.value.sId,
          'tipoBusqueda': tipoBusquedaNutricion.value,
        },
      );

      AnaliticaNutricionModel nutricion =
          AnaliticaNutricionModel.fromJson(response);

      print(response);
      for (Dias dia in nutricion.dias ?? []) {
        charSorce.add(ChartData(
            dia.dia ?? '', dia.promedio?.toDouble() ?? 0, Colors.black));
      }

      analiticaNutricion.value = nutricion;

      isLoading(false);
      refresh();
    } catch (e) {
      charSorce.clear(); // Limpiar datos anteriores

      print(e);
    }
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );

    int index = value.toInt();

    String valor = charSorce[index].label;
    Widget text;
    text = Text(valor, style: style);
    return text;
  }
}

class ChartDataP {
  final DateTime x;
  final double y; // Peso registrado
  final DateTime fecha; // Fecha del registro

  ChartDataP({
    required this.x,
    required this.y,
    required this.fecha,
  });

  factory ChartDataP.fromJson(Map<String, dynamic> json) {
    return ChartDataP(
      x: DateTime.parse(json['fecha']),
      y: (json['y'] as num).toDouble(),
      fecha: DateTime.parse(json['fecha']),
    );
  }
}

class ChartAxis {
  final double minimo;
  final double maximo;

  ChartAxis({
    required this.minimo,
    required this.maximo,
  });

  factory ChartAxis.fromJson(Map<String, dynamic> json) {
    return ChartAxis(
      minimo: (json['minimo'] as num).toDouble(),
      maximo: (json['maximo'] as num).toDouble(),
    );
  }
}
