import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Ejercicio.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:intl/intl.dart';

class PesasController extends GetxController {
  final elementos = [
    {
      'titulo': 'Intenso',
      'descripcion': 'Entrenando hasta el fallo, respiración rapida',
      'value': Intensidad.intenso,
      'intensidad': 2.0
    },
    {
      'titulo': 'Moderado',
      'descripcion': 'Sudando mucho, muchas repeticiones',
      'value': Intensidad.moderado,
      'intensidad': 1.0
    },
    {
      'titulo': 'Ligero',
      'descripcion': 'Sin despeinarse, dando poco esfuerzo',
      'value': Intensidad.ligero,
      'intensidad': 0.0
    },
  ];

  RxString id = ''.obs;

  RxDouble ejercioSlicer = 1.0.obs;
  Rx<Intensidad> intensidad = Intensidad.moderado.obs;
  RxInt duracion = 15.obs;
  RxString ejercicio = 'Levantamiento de pesas'.obs;
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
        'ejercicio/pesas',
        method: Method.POST,
        body: {
          "id": id.value,
          "usuario": usuarioController.usuario.value.sId,
          'tiempo': duracion.value,
          'intensidad': intensidadString,
          'nombre': ejercicio.value,
          'ejercicio': 'Levantamiento de pesas',
          'fecha':
              DateFormat('yyyy-MM-dd').format(controllerCalendario.today.value),
        },
      );

      Get.back();
      Get.back();

      controllerCalendario.cargarEntrenamiento();

      print(response);
    } catch (e) {
      print(e);
    }
  }
}
