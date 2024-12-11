import 'package:cached_network_image/cached_network_image.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class WeeklyCalendarController extends GetxController {
  RxList<AlimentoModel> alimentosList = <AlimentoModel>[].obs;
  final UsuarioController controllerUsuario = Get.find();

  final RxBool loader = false.obs;

  PageController pageController = PageController(initialPage: 0);
  Rx<DateTime> today = DateTime.now().obs;
  DateTime todayCalendar = DateTime.now();

  DateTime getWeekStartDate(int weekOffset) {
    DateTime current = todayCalendar;

    // Aseguramos que no se muestre más de 3 semanas antes de la semana actual
    int maxOffset = -3; // No más de 3 semanas atrás

    // Calculamos la fecha del inicio de la semana según el desplazamiento
    DateTime startOfWeek =
        current.subtract(Duration(days: current.weekday - 1));

    // Calculamos el nuevo desplazamiento, respetando el límite de 3 semanas
    int finalOffset = weekOffset < maxOffset ? maxOffset : weekOffset;

    return startOfWeek.add(Duration(days: finalOffset * 7));
  }

  // Método para verificar si el día es el seleccionado
  bool isSelected(DateTime day) {
    return today.value
        .isSameDay(day); // Usamos la extensión para comparar fechas
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
                      CachedNetworkImage(
                        imageUrl:
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
                            CachedNetworkImage(
                              imageUrl:
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
                      CachedNetworkImage(
                        imageUrl:
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

      final List<AlimentoModel> alimentos =
          AlimentoModel.listFromJson(response['alimentos']);
      alimentosList.value = alimentos;

      controllerUsuario.macronutrientes.value.calorias =
          response['macronutrientes']['totalCalorias'];
      controllerUsuario.macronutrientes.value.proteina =
          response['macronutrientes']['totalProteina'];
      controllerUsuario.macronutrientes.value.carbohidratos =
          response['macronutrientes']['totalCarbohidratos'];
      controllerUsuario.macronutrientes.value.grasas =
          response['macronutrientes']['totalGrasas'];

      refreshCantadorMacronutrientes(controllerUsuario);

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

  void refreshCantadorMacronutrientes(UsuarioController controllerUsuario) {
    final caloriasActual =
        controllerUsuario.macronutrientes.value.calorias ?? 0;
    final caloriasDiarias =
        controllerUsuario.usuario.value.macronutrientesDiario?.value.calorias ??
            0;

    final proteinaActual =
        controllerUsuario.macronutrientes.value.proteina ?? 0;

    final proteinaDiaria =
        controllerUsuario.usuario.value.macronutrientesDiario?.value.proteina ??
            0;

    double porcentajeDiferenciaproteina = proteinaDiaria == 0
        ? 0.0
        : (1 - ((proteinaActual - proteinaDiaria).abs() / proteinaDiaria))
            .clamp(0.0, 1.0);

    final carbohidratosActual =
        controllerUsuario.macronutrientes.value.carbohidratos ?? 0;
    final carbohidratosDiarios = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.carbohidratos ??
        0;

    double porcentajeDiferenciacarbohidratos = carbohidratosDiarios == 0
        ? 0.0
        : (1 -
                ((carbohidratosActual - carbohidratosDiarios).abs() /
                    carbohidratosDiarios))
            .clamp(0.0, 1.0);

    double porcentajeDiferenciaCalorias = caloriasDiarias == 0
        ? 0.0
        : (1 - ((caloriasActual - caloriasDiarias).abs() / caloriasDiarias))
            .clamp(0.0, 1.0);

    final grasasActual = controllerUsuario.macronutrientes.value.grasas ?? 0;
    final grasasDiarias =
        controllerUsuario.usuario.value.macronutrientesDiario?.value.grasas ??
            0;

    double porcentajeDiferenciagrasas = grasasDiarias == 0
        ? 0.0
        : (grasasActual / grasasDiarias).clamp(0.0, 1.0);

    //CALORÍAS
    controllerUsuario.macronutrientes.value.caloriasPorcentaje =
        porcentajeDiferenciaCalorias;
    controllerUsuario.macronutrientes.value.caloriasRestantes =
        caloriasDiarias - caloriasActual;

    //PROTEÍNA
    controllerUsuario.macronutrientes.value.proteinaPorcentaje =
        porcentajeDiferenciaproteina;
    controllerUsuario.macronutrientes.value.proteinaRestantes =
        proteinaDiaria - proteinaActual;

    //CARBOHIDRATOS
    controllerUsuario.macronutrientes.value.carbohidratosPorcentaje =
        porcentajeDiferenciacarbohidratos;
    controllerUsuario.macronutrientes.value.carbohidratosRestante =
        carbohidratosDiarios - carbohidratosActual;

    //GRASAS
    controllerUsuario.macronutrientes.value.grasasRestantes =
        grasasDiarias - grasasActual;

    controllerUsuario.macronutrientes.value.grasasPorcentaje =
        porcentajeDiferenciagrasas;

    controllerUsuario.refresh();

    controllerUsuario.usuario.refresh();
    controllerUsuario.macronutrientes.refresh();
    controllerUsuario.usuario.value.macronutrientesDiario?.refresh();
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
