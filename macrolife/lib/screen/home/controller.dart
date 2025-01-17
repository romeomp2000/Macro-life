import 'package:fl_chart/fl_chart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health/health.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:macrolife/models/racha_dias.model.dart';
import 'package:macrolife/widgets_home_screen/controller.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';
// import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class WeeklyCalendarController extends GetxController {
  final verAppleHealth = false.obs;
  //? controller helth
  var healthData = <HealthDataPoint>[].obs; // Observar los datos de salud
  var isLoading = true.obs; // Estado de carga
  final RxList<ChartData> charSorce = <ChartData>[].obs;
  final widht = 1.0.obs;
  final health = HealthFactory();
  final pasosHoy = 0.0.obs;

  RxInt caloriasQuemadas = 0.obs;
  RxInt levantamientoPesass = 0.obs;
  RxInt pasos = 0.obs;
  RxInt otro = 0.obs;

  final List<String> daysOfWeek = [
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo'
  ];

  Future<void> fetchHealthData() async {
    if (GetPlatform.isAndroid) {
      return;
    }
    isLoading(true);

    // Solicitar permisos
    bool isAuthorized = await health.requestAuthorization([
      HealthDataType.STEPS,
    ]);

    if (isAuthorized) {
      // Obtener la fecha actual
      // DateTime now = DateTime.now();

      DateTime startDate =
          today.value.subtract(Duration(days: 6)); // Últimos 7 días

      // Obtener los datos de pasos
      List<HealthDataPoint> data = await health.getHealthDataFromTypes(
        startDate,
        today.value,
        [HealthDataType.STEPS],
      );

      healthData.value = data; // Asignar los datos obtenidos

      // Iniciales de los días en español
      List<String> diasIniciales = [
        "Dom",
        "Lun",
        "Mar",
        "Mie",
        "Jue",
        "Vie",
        "Sab"
      ];

      // Mapa para almacenar pasos por día
      Map<String, int> stepsPerDay = {
        for (int i = 6; i >= 0; i--)
          diasIniciales[(today.value.weekday - i + 7) % 7]: 0
      };

      double pasosHoyTemp = 0.0; // Variable temporal para los pasos de hoy

      // Filtrar pasos y sumarlos por día
      for (HealthDataPoint element in data) {
        DateTime date = element.dateFrom;
        String dia = diasIniciales[date.weekday % 7];

        final json = element.value.toJson();
        double numericValue = double.parse(json['numericValue']);

        stepsPerDay[dia] = (stepsPerDay[dia] ?? 0) + numericValue.toInt();

        // Si la fecha corresponde al día actual, acumular los pasos
        if (date.day == today.value.day &&
            date.month == today.value.month &&
            date.year == today.value.year) {
          pasosHoyTemp += numericValue;
        }
      }

      pasosHoy.value = pasosHoyTemp; // Asignar los pasos de hoy

      // Crear datos del gráfico en el orden deseado
      charSorce.clear(); // Limpiar datos anteriores
      stepsPerDay.entries.forEach((entry) {
        charSorce
            .add(ChartData(entry.key, entry.value.toDouble(), Colors.black));
      });
    } else {
      print("No se otorgaron permisos para acceder a los datos.");
    }

    isLoading(false);
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

  RxList<AlimentoModel> alimentosList = <AlimentoModel>[].obs;

  // final HealthController healthController = Get.put(HealthController());
  final UsuarioController controllerUsuario = Get.find();

  final RxBool loader = false.obs;
  final widgetController = Get.put(WidgetController());
  // final liveWidgetController = Get.put(LiveDynamicController());

  PageController pageController = PageController(initialPage: 0);
  Rx<DateTime> today = DateTime.now().obs;
  DateTime todayCalendar = DateTime.now();
  Rx<RachaDiasModel> rechaDias = RachaDiasModel(
    lun: false,
    mar: false,
    mie: true,
    jue: false,
    vie: false,
    sab: false,
    dom: false,
  ).obs;

  // DateTime getWeekStartDate(int weekOffset) {
  //   DateTime current = todayCalendar;
  //   // Aseguramos que no se muestre más de 3 semanas antes de la semana actual
  //   int maxOffset = -3; // No más de 3 semanas atrás
  //   // Calculamos la fecha del inicio de la semana según el desplazamiento
  //   DateTime startOfWeek =
  //       current.subtract(Duration(days: current.weekday - 1));
  //   // Calculamos el nuevo desplazamiento, respetando el límite de 3 semanas
  //   int finalOffset = weekOffset < maxOffset ? maxOffset : weekOffset;
  //   return startOfWeek.add(Duration(days: finalOffset * 7));
  // }

  DateTime getWeekStartDate(int index) {
    int adjustedIndex = -index;
    DateTime today = DateTime.now();
    int currentWeekDay = today.weekday;
    DateTime startOfThisWeek =
        today.subtract(Duration(days: currentWeekDay - 1));
    return startOfThisWeek.add(Duration(days: 7 * adjustedIndex));
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
                      Image.asset(
                        'assets/icons/logo_macro_life_1125x207.png',
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
                            Image.asset(
                              'assets/icons/icono_rutina_60x60_nuevo.png',
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
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/imagen_racha_600x600_sn.png',
                        width: 220,
                        height: 220,
                      ),
                      Positioned(
                        top: 85,
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
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Indicador de días
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Obx(() {
                      // Obtenemos el modelo reactivo
                      final racha = rechaDias.value;

                      // Mapear las claves y valores
                      final Map<String, bool?> diasMap = {
                        "Lun": racha.lun,
                        "Mar": racha.mar,
                        "Mie": racha.mie,
                        "Jue": racha.jue,
                        "Vie": racha.vie,
                        "Sab": racha.sab,
                        "Dom": racha.dom,
                      };

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: diasMap.keys.map((dia) {
                          final bool? estado = diasMap[dia];
                          return Column(
                            children: [
                              Text(
                                dia,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (estado == true)
                                Container(
                                  width: 18, // Ancho del cuadrado
                                  height: 18, // Alto del cuadrado
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.black45, // Color del borde
                                      width: 1, // Grosor del borde
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                )
                              else
                                Container(
                                  width: 18, // Ancho del cuadrado
                                  height: 18, // Alto del cuadrado
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Colors.black45, // Color del borde
                                        width: 1, // Grosor del borde
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                            ],
                          );
                        }).toList(),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),
                  // Mensaje
                  const Text(
                    "¡Sigue así! Los objetivos se cumplen día tras día",
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  bool isSelected(DateTime day) {
    return isSameDay(today.value, day);
  }

  @override
  void onInit() {
    super.onInit();
    today.value = DateTime.now();
    cargaAlimentos();
    fetchHealthData();
  }

  RxList<Entrenamiento> entrenamientosList = <Entrenamiento>[].obs;
  // RxBool loaderEn = false.obs;

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  Future cargarRacha() async {
    try {
      if (controllerUsuario.usuario.value.sId == null) {
        return;
      }
      final apiService = ApiService();

      // Realiza la llamada a la API
      final response = await apiService.fetchData(
        'racha_dias/${controllerUsuario.usuario.value.sId}',
        method: Method.GET,
        body: {},
      );

      // Convierte la respuesta en un modelo de datos
      final RachaDiasModel racha = RachaDiasModel.fromJson(response);

      // Asigna el valor al observable
      rechaDias.value = racha;
    } catch (e) {
      // Manejo de errores
      // Get.snackbar(
      //   'Racha Días',
      //   e.toString(),
      //   snackPosition: SnackPosition.TOP,
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
  }

  Future cargarEntrenamiento() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'ejercicio/obtener',
        method: Method.POST,
        body: {
          "fecha": DateFormat('yyyy-MM-dd').format(today.value),
          "idUsuario": controllerUsuario.usuario.value.sId
        },
      );

      final List<Entrenamiento> entrenamientos =
          Entrenamiento.listFromJson(response['ejercicios']);

      // final HealthController healthController = Get.put(HealthController());

      caloriasQuemadas.value = response['caloriasQuemadas'] ?? 0;
      levantamientoPesass.value = response['levantamientoPesass'] ?? 0;
      pasos.value = response['pasos'] ?? 0;
      otro.value = response['otros'] ?? 0;

      // caloriasQuemadas, levantamientoPesass, pasos, otro
      entrenamientosList.value = entrenamientos;

      loader.value = false;
    } catch (e) {
      Get.snackbar(
        'Entrenamiento',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future cargaAlimentos() async {
    try {
      cargarEntrenamiento();
      cargarRacha();
      fetchHealthData();

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
      controllerUsuario.macronutrientes.value.caloriasQuemadas =
          response['macronutrientes']['caloriasQuemadas'];

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

    double porcentajeDiferenciaproteina = proteinaActual / proteinaDiaria;

    // Si el porcentaje supera el 100%, debe ser 1.0
    if (porcentajeDiferenciaproteina > 1.0) {
      porcentajeDiferenciaproteina = 1.0;
    }

    if (porcentajeDiferenciaproteina < 0.0) {
      porcentajeDiferenciaproteina = 0.0;
    }

    final carbohidratosActual =
        controllerUsuario.macronutrientes.value.carbohidratos ?? 0;
    final carbohidratosDiarios = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.carbohidratos ??
        0;

    double porcentajeDiferenciacarbohidratos =
        carbohidratosActual / carbohidratosDiarios;

    // Si el porcentaje supera el 100%, debe ser 1.0
    if (porcentajeDiferenciacarbohidratos > 1.0) {
      porcentajeDiferenciacarbohidratos = 1.0;
    }

    if (porcentajeDiferenciacarbohidratos < 0.0) {
      porcentajeDiferenciacarbohidratos = 0.0;
    }

    // Cálculo del porcentaje
    double porcentajeDiferenciaCalorias = caloriasActual / caloriasDiarias;

    // Si el porcentaje supera el 100%, debe ser 1.0
    if (porcentajeDiferenciaCalorias > 1.0) {
      porcentajeDiferenciaCalorias = 1.0;
    }

    if (porcentajeDiferenciaCalorias < 0.0) {
      porcentajeDiferenciaCalorias = 0.0;
    }

    final grasasActual = controllerUsuario.macronutrientes.value.grasas ?? 0;
    final grasasDiarias =
        controllerUsuario.usuario.value.macronutrientesDiario?.value.grasas ??
            0;

    double porcentajeDiferenciagrasas = grasasActual / grasasDiarias;

    // Si el porcentaje supera el 100%, debe ser 1.0
    if (porcentajeDiferenciagrasas > 1.0) {
      porcentajeDiferenciagrasas = 1.0;
    }

    if (porcentajeDiferenciagrasas < 0.0) {
      porcentajeDiferenciagrasas = 0.0;
    }
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

    if (GetPlatform.isIOS) {
      final liveActivitiesController = Get.put(LiveActivitiesController());
      int carbohidratos =
          controllerUsuario.macronutrientes.value.carbohidratosRestante!;
      int calorias = controllerUsuario.macronutrientes.value.caloriasRestantes!;
      int protein = controllerUsuario.macronutrientes.value.proteinaRestantes!;
      int grasas = controllerUsuario.macronutrientes.value.grasasRestantes!;

      int limiteCal = controllerUsuario.macronutrientes.value.calorias!;
      int limiteCarbs = controllerUsuario.macronutrientes.value.carbohidratos!;
      int limiteProtein = controllerUsuario.macronutrientes.value.proteina!;
      int limiteFats = controllerUsuario.macronutrientes.value.grasas!;
      GetStorage box = GetStorage();

      widgetController.updateHomeWidget(calorias.toString(), limiteCal,
          carbohidratos.toString(), grasas.toString(), protein.toString());

      bool? estado = box.read('liveActivitiesEnable');
      if (estado != null && estado == true) {
        if (estado == true) {
          liveActivitiesController.createLiveActivities(
              calorias,
              carbohidratos,
              grasas,
              protein,
              limiteProtein,
              limiteCal,
              limiteCarbs,
              limiteFats);
        }

        liveActivitiesController.actualizar(calorias, carbohidratos, grasas,
            protein, limiteProtein, limiteCal, limiteCarbs, limiteFats);
      }
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
            fontSize: 60,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 8
              ..color = Colors.white,
          ),
        ),
        // Texto interior
        Text(
          number,
          style: const TextStyle(
            fontSize: 60,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
