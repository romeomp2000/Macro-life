import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.psd.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/widgets/AnimatedFood.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FoodDatabaseController extends GetxController {
  final describirController = TextEditingController();
  final UsuarioController usuarioController = Get.put(UsuarioController());
  final WeeklyCalendarController controllerCalendario = Get.find();
  final AnimatedFoodController controllerAnimatedFood =
      Get.put(AnimatedFoodController(), permanent: true);

  final RxString id = ''.obs;
  final RxString image = ''.obs;

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
      // controllerCalendario.loader.value = true;

      final apiService = ApiService();
      String fecha = controllerCalendario.today.value.toIso8601String();
      controllerAnimatedFood.loading.value = true;
      controllerAnimatedFood.imagen.value = await urlToXFile(image.value);

      final response = await apiService.fetchData(
        'analizar-comida/describir',
        method: Method.POST,
        body: {
          "usuario": usuarioController.usuario.value.sId,
          'comida': describirController.text,
          'fecha': fecha,
          'id': id.value
        },
      );

      controllerCalendario.cargaAlimentos();

      print(response);
    } catch (e) {
      print(e);
    } finally {
      controllerAnimatedFood.loading.value = false;
    }
  }

  Future<XFile?> urlToXFile(String imageUrl) async {
    try {
      // Descargar la imagen desde la URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Obtener un directorio temporal para almacenar la imagen
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/temp_image.jpg';

        // Guardar la imagen descargada en el sistema de archivos
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Crear un XFile a partir de la imagen guardada
        return XFile(filePath);
      } else {
        print(
            "Error: No se pudo descargar la imagen. Código ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
