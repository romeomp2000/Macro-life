import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Ejercicio.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:intl/intl.dart';

class CorrerController extends GetxController {
  final elementos = [
    {
      'titulo': 'Intenso',
      'descripcion': 'Correr - 14 mph (millas 4 minutos)',
      'value': Intensidad.intenso,
      'intensidad': 2.0
    },
    {
      'titulo': 'Moderado',
      'descripcion': 'Trotar - 6mph (millas de 10 minutos)',
      'value': Intensidad.moderado,
      'intensidad': 1.0
    },
    {
      'titulo': 'Ligero',
      'descripcion': 'Caminata relajada -3 mph (20 minutos)',
      'value': Intensidad.ligero,
      'intensidad': 0.0
    },
  ];

  RxString id = ''.obs;

  RxDouble ejercioSlicer = 1.0.obs;
  Rx<Intensidad> intensidad = Intensidad.moderado.obs;
  RxInt duracion = 15.obs;
  RxString ejercicio = 'Trotar'.obs;
  final UsuarioController usuarioController = Get.find();

  final duracionController = TextEditingController(text: '15');
  final WeeklyCalendarController controllerCalendario = Get.find();

  void registrarEntrenamiento() async {
    try {
      final apiService = ApiService();

      String intensidadString = '';

      if (intensidad.value == Intensidad.intenso) {
        intensidadString = 'Intenso';
      } else if (intensidad.value == Intensidad.moderado) {
        intensidadString = 'Moderado';
      } else if (intensidad.value == Intensidad.ligero) {
        intensidadString = 'Ligero';
      }

      final response = await apiService.fetchData(
        'ejercicio/ejecutar',
        method: Method.POST,
        body: {
          "id": id.value,
          "usuario": usuarioController.usuario.value.sId,
          'tiempo': duracion.value,
          'intensidad': intensidadString,
          'nombre': ejercicio.value,
          'ejercicio': 'Ejecutar',
          'fecha':
              DateFormat('yyyy-MM-dd').format(controllerCalendario.today.value),
        },
      );

      Get.back();
      Get.back();

      controllerCalendario.cargaAlimentos();

      print(response);
    } catch (e) {
      print(e);
    }
  }

  void eliminarEjercicio(String id) async {
    try {
      Get.back();

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'ejercicio/$id',
        method: Method.DELETE,
        body: {},
      );

      controllerCalendario.cargaAlimentos();

      print(response);
    } catch (e) {
      print(e);
    }
  }
}
