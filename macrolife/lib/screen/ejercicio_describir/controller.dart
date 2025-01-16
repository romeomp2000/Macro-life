import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';

class EjercicioDescribirController extends GetxController {
  String obtenerActividadAleatoria() {
    final random = Random();
    final indiceAleatorio = random.nextInt(actividades.length);
    return actividades[indiceAleatorio];
  }

  final actividades = [
    "Correr cuesta arriba por 20 minutos, piernas agotadas.",
    "Hacer sentadillas con peso durante 10 series, cuadriceps quemando.",
    "Montar bicicleta en subida durante 30 minutos, muslos ardiendo.",
    "Practicar saltos de caja (box jumps) por 15 minutos, pantorrillas agotadas.",
    "Hacer zancadas con pesas durante 20 minutos, glúteos y piernas ardiendo.",
    "Escalar una pared de roca durante 30 minutos, brazos y piernas cansados.",
    "Subir y bajar un cerro pequeño corriendo por 25 minutos, pulmones y piernas exigiendo.",
    "Hacer burpees sin descanso durante 10 minutos, cuerpo en llamas.",
    "Caminar cargando peso en la espalda durante 30 minutos, muslos ardiendo.",
    "Correr en la arena por 15 minutos, pantorrillas y muslos tensos.",
    "Practicar sprints de 100 metros repetidamente por 20 minutos, piernas ardiendo.",
    "Hacer mountain climbers durante 10 minutos, abdomen y piernas fatigados.",
    "Escalar escaleras mecánicas apagadas con mochila durante 20 minutos, cuadriceps agotados.",
    "Practicar estocadas en pendiente durante 15 minutos, piernas quemando.",
    "Cargar cajas pesadas subiendo pisos de un edificio por 30 minutos.",
    "Hacer remo en máquina de resistencia durante 20 minutos, espalda y brazos tensos.",
    "Realizar ejercicios pliométricos con saltos por 15 minutos, explosividad agotadora.",
    "Realizar peso muerto con peso moderado en sets largos, glúteos y espalda activados.",
    "Trotar escaleras de un estadio por 25 minutos, piernas y pulmones trabajando duro.",
    "Subir una colina con inclinación empinada durante 20 minutos.",
    "Practicar boxeo o kickboxing con movimientos rápidos por 30 minutos.",
    "Correr en cinta con resistencia elevada durante 25 minutos.",
    "Hacer ejercicios de calistenia con enfoque en piernas por 20 minutos.",
    "Participar en un entrenamiento de crossfit con muchas repeticiones de piernas.",
    "Realizar saltos de cuerda a alta velocidad durante 15 minutos, piernas ardiendo."
  ];

  final describirController = TextEditingController();

  RxString id = ''.obs;

  final UsuarioController usuarioController = Get.find();

  final WeeklyCalendarController controllerCalendario = Get.find();

  void registrarEntrenamiento() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'ejercicio/describir',
        method: Method.POST,
        body: {
          "id": id.value,
          "usuario": usuarioController.usuario.value.sId,
          'descripcion': describirController.text,
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
