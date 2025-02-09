// import 'package:camera/camera.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health/health.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
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
import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class WeeklyCalendarController extends GetxController {
  final box = GetStorage();

  final verAppleHealth = false.obs;
  //? controller helth
  var healthData = <HealthDataPoint>[].obs; // Observar los datos de salud
  // RxList<WorkOutActivities> healthDataWorKout = <WorkOutActivities>[].obs;
  RxList<WorkOutActivitiesData> healthDataWorKout =
      <WorkOutActivitiesData>[].obs;
  var isLoading = true.obs; // Estado de carga
  final RxList<ChartData> charSorce = <ChartData>[].obs;
  final widht = 1.0.obs;
  final health = HealthFactory();
  final pasosHoy = 0.0.obs;
  final RxBool isCaloriasQuemadas = false.obs;

  RxInt caloriasQuemadas = 0.obs;
  RxInt levantamientoPesass = 0.obs;
  RxInt pasos = 0.obs;
  RxInt otro = 0.obs;
  RxInt maximo = 0.obs;
  RxDouble caloriasHealthApple = 0.0.obs;

  final List<String> daysOfWeek = [
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo'
  ];

  void actualizarCaloriasQuemadas(value) {
    isCaloriasQuemadas.value = value;
    box.write('caloriasQuemadasEnable', isCaloriasQuemadas.value);
    isCaloriasQuemadas.refresh();

    cargaAlimentos();
  }

  Future<void> fetchWorkOut() async {
    try {
      if (GetPlatform.isAndroid) {
        return;
      }

      bool isAuthorized = await health.requestAuthorization([
        HealthDataType.WORKOUT,
      ]);

      if (!isAuthorized) {
        return;
      }
      healthDataWorKout.clear();
      caloriasHealthApple.value = 0;
      DateTime startDate = DateTime(
          today.value.year, today.value.month, today.value.day, 0, 0, 0);
      DateTime endDate = DateTime(
          today.value.year, today.value.month, today.value.day, 23, 59, 59);
      List<HealthDataPoint> data = await health.getHealthDataFromTypes(
        startDate,
        endDate,
        [HealthDataType.WORKOUT],
      );

      if (data.isNotEmpty) {
        List<WorkOutActivitiesData> workoutActivities = [];

        for (HealthDataPoint point in data) {
          HealthValue healthValue = point.value;
          Map<String, dynamic> valueJson = healthValue.toJson();
          String? hora = DateFormat('hh:mm a')
              .format(DateTime.parse(point.dateFrom.toString()))
              .toLowerCase();

          String? nombre = valueJson['workoutActivityType'];
          nombre = FuncionesGlobales().translateActivity(nombre!);
          double? cal = valueJson['totalEnergyBurned'] != null
              ? double.tryParse(valueJson['totalEnergyBurned'].toString())
              : null;
          double? distancia = valueJson['totalDistance'] != null
              ? double.tryParse(valueJson['totalDistance'].toString())
              : null;
          String? unidad = valueJson['totalEnergyBurnedUnit'];

          DateTime dateFrom = DateTime.parse(point.dateFrom.toString());
          DateTime dateTo = DateTime.parse(point.dateTo.toString());
          Duration difference = dateTo.difference(dateFrom);
          // int durationInMinutes = difference.inMinutes;

          WorkOutActivitiesData data = WorkOutActivitiesData(
              hora: hora,
              nombre: nombre,
              tiempo: int.parse(difference.inMinutes.toString()).toString(),
              cal: cal,
              distancia: distancia,
              unidad: unidad);
          workoutActivities.add(data);
          caloriasHealthApple.value = caloriasHealthApple.value + cal!;
        }
        healthDataWorKout.value = workoutActivities;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchHealthData() async {
    if (GetPlatform.isAndroid) {
      return;
    }
    isLoading(true);

    bool isAuthorized = await health.requestAuthorization([
      HealthDataType.STEPS,
    ]);

    if (isAuthorized) {
      // Obtener la fecha actual
      DateTime startDate = today.value.subtract(Duration(days: 6));

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

        if (date.day == today.value.day &&
            date.month == today.value.month &&
            date.year == today.value.year) {
          pasosHoyTemp += numericValue;
        }
      }

      pasosHoy.value = pasosHoyTemp;

      var maxSteps =
          stepsPerDay.values.fold(0, (max, steps) => steps > max ? steps : max);
      maximo.value = maxSteps + 1000;
      charSorce.clear();
      stepsPerDay.entries.forEach((entry) {
        charSorce
            .add(ChartData(entry.key, entry.value.toDouble(), Colors.black));
      });
    } else {
      if (kDebugMode) {
        print("No se otorgaron permisos para acceder a los datos.");
      }
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

  // final RxBool loader = false.obs;
  // final Rx<XFile?> imagenLoader = Rx<XFile?>(null);
  // final RxBool loaderAnimated = false.obs;

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
      isDismissible: true,
      enableDrag: true,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/imagen_fondo_racha_690x690_1.png',
                        width: 240,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    axisLineStyle: const AxisLineStyle(
                                      thickness: 0.2,
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      color: Colors.black12,
                                    ),
                                    showTicks: false,
                                    showLabels: false,
                                    showLastLabel: false,
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: (controllerUsuario
                                                    .usuario.value.rachaDias
                                                    ?.toDouble() ??
                                                0) *
                                            5,
                                        color: blackTheme_,
                                        cornerStyle: CornerStyle.bothCurve,
                                        enableDragging: true,
                                        width: 0.2,
                                        sizeUnit: GaugeSizeUnit.factor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: blackTheme_,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Obx(
                          () => NumberWithBorder(
                              number:
                                  '${controllerUsuario.usuario.value.rachaDias}'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Texto principal
                  const Text(
                    "Racha de días",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: blackTheme_,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Indicador de días
                  SizedBox(
                    child: Obx(() {
                      final racha = rechaDias.value;

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
                                    fontWeight: FontWeight.w500,
                                    color: blackThemeText),
                              ),
                              const SizedBox(height: 4),
                              if (estado == true)
                                Container(
                                  alignment: Alignment.center,
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: blackTheme_,
                                    border: Border.all(
                                      color: blackTheme_,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: whiteTheme_,
                                    size: 12,
                                  ),
                                )
                              else
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: blackTheme_,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
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
                    style: TextStyle(
                        fontSize: 15,
                        color: blackThemeText,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  // Botón continuar
                  SizedBox(
                    width: double.infinity, // Ocupa todo el ancho disponible
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: blackTheme_,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
    bool? caloriasQuemadas = box.read('caloriasQuemadasEnable');
    if (caloriasQuemadas != null) {
      isCaloriasQuemadas.value = caloriasQuemadas;
    } else {
      isCaloriasQuemadas.value = false;
      box.write('caloriasQuemadasEnable', isCaloriasQuemadas.value);
    }
    today.value = DateTime.now();
    cargaAlimentos();
    fetchHealthData();
    fetchWorkOut();
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

      // loader.value = false;
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
      await fetchWorkOut();

      final UsuarioController controllerUsuario = Get.find();

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'alimentos',
        method: Method.POST,
        body: {
          "fecha": DateFormat('yyyy-MM-dd').format(today.value),
          "idUsuario": controllerUsuario.usuario.value.sId,
          'isCaloriasQuemadas': isCaloriasQuemadas.value,
          "caloriasHealthApple": caloriasHealthApple.value,
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

      // loader.value = false;
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

      double caloriasLimite =
          controllerUsuario.macronutrientes.value.caloriasPorcentaje!;

      double carbsPercent =
          controllerUsuario.macronutrientes.value.caloriasPorcentaje!;
      double fatsPercent =
          controllerUsuario.macronutrientes.value.grasasPorcentaje!;
      double proPercent =
          controllerUsuario.macronutrientes.value.proteinaPorcentaje!;
      GetStorage box = GetStorage();

      widgetController.updateHomeWidget(
        calorias.toString(),
        carbohidratos.toString(),
        grasas.toString(),
        protein.toString(),
        caloriasLimite,
        fatsPercent,
        proPercent,
        carbsPercent,
      );

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
          // return;
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
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class WorkOutActivities {
  final String dia;
  final List<HealthDataPoint> actividades;

  WorkOutActivities(
    this.dia,
    this.actividades,
  );
}

class WorkOutActivitiesData {
  final String? hora;
  final double? cal;
  final String? nombre;
  final String? unidad;
  final String? tiempo;
  final double? distancia;

  WorkOutActivitiesData({
    this.hora,
    this.nombre,
    this.cal,
    this.distancia,
    this.unidad,
    this.tiempo,
  });
}
