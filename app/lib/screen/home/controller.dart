import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeeklyCalendarController extends GetxController {
  RxList<NutritionInfo> alimentosList =
      <NutritionInfo>[].obs; // Lista vacía de tipo NutritionInfo
  final UsuarioController controllerUsuario = Get.find();

  final RxBool loader = false.obs;

  PageController pageController = PageController(initialPage: 0);
  Rx<DateTime> today = DateTime.now().obs;

  DateTime getWeekStartDate(int weekOffset) {
    DateTime current = today.value;
    return current
        .subtract(Duration(days: current.weekday - 1 + weekOffset * 7));
  }

  void onRachaDias() {
    Get.bottomSheet(
      isDismissible: true, // Permite cerrar al presionar fuera
      enableDrag: true, // Permite deslizar para cerrar
      persistent: true,
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Logo e ícono de fuego
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons.apple, size: 24, color: Colors.black),
                      Image.network(
                        'https://macrolife.app/images/app/logo/logo_macro_life.png',
                        height: 20,
                      ),

                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            Image.network(
                              'https://macrolife.app/images/app/home/icono_flama_chica_52x52_original.png',
                              width: 20,
                            ),
                            const SizedBox(width: 5),
                            Obx(
                              () => Text(
                                '${controllerUsuario.usuario.value.rachaDias}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Ícono de fuego grande
                  Stack(
                    alignment: Alignment
                        .center, // Centrar los widgets dentro del Stack
                    clipBehavior: Clip
                        .none, // Permite que los widgets se desborden fuera del Stack
                    children: [
                      Image.network(
                        'https://macrolife.app/images/app/home/imagen_flama_num_378x462_no_sn.png',
                        width: 130,
                        height: 140,
                      ),
                      Positioned(
                        bottom:
                            -25, // Ajusta este valor para mover el texto donde desees
                        child: Obx(
                          () => NumberWithBorder(
                              number:
                                  '${controllerUsuario.usuario.value.rachaDias}'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Texto principal
                  const Text(
                    "Racha de días",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE69938),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Indicador de días
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(7, (index) {
                        return Column(
                          children: [
                            Text(
                              ["L", "M", "M", "J", "V", "S", "D"][index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              index == 4
                                  ? Icons.check_circle
                                  : Icons.circle_rounded,
                              color: index == 4
                                  ? const Color(0xFFE69938)
                                  : Colors.grey[200],
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Mensaje
                  const Text(
                    "¡Estás que ardes! Cada día cuenta para alcanzar tu meta",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Botón continuar
                  SizedBox(
                    width: double.infinity, // Ocupa todo el ancho disponible
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: const Text(
                        "Continuar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isToday(DateTime date) {
    DateTime current = DateTime.now();
    return date.day == current.day &&
        date.month == current.month &&
        date.year == current.year;
  }

  @override
  void onInit() async {
    super.onInit();
    cargaAlimentos();
  }

  Future cargaAlimentos() async {
    try {
      final UsuarioController controllerUsuario = Get.find();

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'alimentos',
        method: Method.POST,
        body: {
          "fecha": DateFormat('yyyy-MM-dd').format(today.value),
          "idUsuario": controllerUsuario.usuario.value.sId
        },
      );

      final List<NutritionInfo> alimentos =
          NutritionInfo.listFromJson(response['alimentos']);
      alimentosList.value = alimentos;

      loader.value = false;
    } catch (e) {
      Get.snackbar(
        'Macronutrientes',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}

class NumberWithBorder extends StatelessWidget {
  final String number;

  const NumberWithBorder({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Texto con borde (más grande)
        Text(
          number,
          style: TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 14 // Grosor del borde
              ..color = const Color(0xFFE69938), // Color del borde
          ),
        ),
        // Texto interior
        Text(
          number,
          style: const TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto interno
          ),
        ),
      ],
    );
  }
}

class NutritionInfo {
  final String imageUrl;
  final String name;
  final String time;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  // Constructor
  NutritionInfo({
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'time': time,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  // Método para crear el objeto a partir de JSON
  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      imageUrl: json['imageUrl'],
      name: json['name'],
      time: json['time'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
    );
  }

  // Método para convertir una lista de objetos a JSON
  static List<Map<String, dynamic>> listToJson(
      List<NutritionInfo> nutritionInfos) {
    return nutritionInfos
        .map((nutritionInfo) => nutritionInfo.toJson())
        .toList();
  }

  // Método para crear una lista de objetos a partir de JSON
  static List<NutritionInfo> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => NutritionInfo.fromJson(json)).toList();
  }
}
