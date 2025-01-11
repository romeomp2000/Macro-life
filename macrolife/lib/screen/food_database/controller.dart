import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.psd.dart';
import 'package:macrolife/screen/home/controller.dart';

class FoodDatabaseController extends GetxController {
  final describirController = TextEditingController();
  final UsuarioController usuarioController = Get.put(UsuarioController());
  final WeeklyCalendarController controllerCalendario = Get.find();

  List<String> comidas = [
    "Acabo de comer 150g de pechuga de pollo con 100g de ensalada.",
    "Hoy cené 200g de pescado a la plancha con 50g de quinoa.",
    "Desayuné 2 huevos revueltos con 1 rebanada de pan integral.",
    "Almorcé 250g de carne asada con 80g de puré de papa.",
    "Merendé 30g de almendras con un plátano pequeño.",
    "Cené 200g de tofu con 100g de vegetales al vapor.",
    "Disfruté un plato de 150g de pasta integral con salsa de tomate.",
    "Comí 120g de salmón a la parrilla con 60g de brócoli.",
    "Hoy desayuné un yogurt natural con 50g de granola.",
    "Almorcé 180g de filete de res con 70g de arroz integral.",
    "Merendé 25g de nueces con una manzana verde.",
    "Cené 200g de pechuga de pollo con 80g de zanahorias al vapor.",
    "Tomé 250 ml de smoothie de frutas con 30g de avena.",
    "Almorcé 200g de atún fresco con 50g de espinacas.",
    "Desayuné un omelette con 2 claras de huevo y 40g de champiñones."
  ];

  String obtenerActividadAleatoria() {
    final random = Random();
    final indiceAleatorio = random.nextInt(comidas.length);
    return comidas[indiceAleatorio];
  }

  final buscadorController = TextEditingController();

  RxList<AlimentosPSD> alimentos = <AlimentosPSD>[].obs;
  RxBool loading = false.obs;

  void buscarAlimento(String alimento) async {
    try {
      if (alimento.isEmpty) {
        return;
      }
      loading.value = true;
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'food-database',
        method: Method.POST,
        body: {'search': alimento.trim().toLowerCase()},
      );

      alimentos.value = AlimentosPSD.fromJsonList(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      loading.value = false;
    }
  }

  void registrarComida() async {
    try {
      Get.back();
      Get.back();
      controllerCalendario.loader.value = true;

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'analizar-comida/describir',
        method: Method.POST,
        body: {
          "usuario": usuarioController.usuario.value.sId,
          'comida': describirController.text,
          'fecha':
              DateFormat('yyyy-MM-dd').format(controllerCalendario.today.value),
        },
      );

      controllerCalendario.cargaAlimentos();

      print(response);
    } catch (e) {
      print(e);
    }
  }
}
