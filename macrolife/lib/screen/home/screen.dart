import 'package:cached_network_image/cached_network_image.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/correr/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/nutricion/screen.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:macrolife/widgets/NutrientIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();

    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController());

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/logo_macro_life_1125x207.png',
                    width: 155,
                  ),
                  GestureDetector(
                    onTap: () => controller.onRachaDias(),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                  ),
                ],
              ),
              const SizedBox(height: 15),
              calendario(controller),
              GestureDetector(
                onTap: () => Get.toNamed('/objetivos'),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 0.1,
                      ),
                    ],
                  ),
                  width: Get.width,
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 85,
                              child: Obx(
                                () => SfCartesianChart(
                                  primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    maximum: 100,
                                    interval: 50,
                                    opposedPosition: true,
                                    borderColor: Colors.black12,
                                  ),
                                  plotAreaBackgroundColor: Colors.black12,
                                  primaryXAxis: CategoryAxis(
                                    isVisible: false,
                                  ),
                                  enableSideBySideSeriesPlacement: false,
                                  series: <CartesianSeries>[
                                    // Inicializa la serie de columnas (barras)
                                    ColumnSeries<ChartData, String>(
                                      dataSource: [
                                        // Fuente de datos
                                        ChartData(
                                            '',
                                            controllerUsuario.macronutrientes
                                                    .value.caloriasPorcentaje
                                                    ?.toDouble() ??
                                                0.0,
                                            Colors.white),
                                      ],
                                      width: 1,
                                      color: Colors.black,
                                      xValueMapper: (ChartData data, _) =>
                                          data.label,
                                      yValueMapper: (ChartData data, _) =>
                                          data.value,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                              width: 25,
                            )
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.black26,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    '${controllerUsuario.macronutrientes.value.caloriasRestantes ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Calorías\nrestantes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Indicador de Proteína
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: Obx(
                      () => NutrientIndicator(
                        amount: (controllerUsuario
                                .macronutrientes.value.proteinaRestantes ??
                            0),
                        nutrient: "Proteína",
                        percent: controllerUsuario
                                .macronutrientes.value.proteinaPorcentaje
                                ?.toDouble() ??
                            0.0,
                        color: Colors.red,
                        icon: 'assets/icons/icono_filetecarne_90x69_nuevo.png',
                      ),
                    ),
                  ),
                  // Indicador de Carbohidratos
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: Obx(
                      () => NutrientIndicator(
                        amount: (controllerUsuario
                                .macronutrientes.value.carbohidratosRestante ??
                            0),
                        nutrient: "Carbohidratos",
                        percent: controllerUsuario
                                .macronutrientes.value.caloriasPorcentaje
                                ?.toDouble() ??
                            0.0,
                        color: Colors.orange,
                        icon:
                            'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                      ),
                    ),
                  ),
                  // Indicador de Grasa
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: Obx(
                      () => NutrientIndicator(
                        amount: (controllerUsuario
                                .macronutrientes.value.grasasRestantes ??
                            0),
                        nutrient: "Grasa",
                        percent: controllerUsuario
                                .macronutrientes.value.grasasPorcentaje
                                ?.toDouble() ??
                            0.0,
                        color: Colors.blue,
                        icon: 'assets/icons/icono_almedraazul_74x70_nuevo.png',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Obx(
                () => controller.alimentosList.isEmpty
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '¡Inicia hoy!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  SizedBox(
                                    width: Get.width - 200,
                                    child: Text(
                                      'Escanea tus alimentos y lleva un control exacto',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: Get.width / 2 - 80,
                            bottom: -60,
                            child: Image.asset(
                              'assets/icons/flecha_curva_negra_227x222_nuevo_1.png',
                              width: 70,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            'Recientemente registros',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
              ),
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (controller.loader.value)
                        const LinearProgressIndicator(),
                      for (var alimento in controller.alimentosList)
                        NutritionWidget(nutritionInfo: alimento),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              Obx(() {
                return SingleChildScrollView(
                  // Permite que el contenido sea desplazable
                  child: Column(
                    // Se puede usar Column para manejar el tamaño dinámico
                    children: [
                      if (controller.loader.value)
                        const LinearProgressIndicator(),
                      for (var alimento in controller.entrenamientosList)
                        EjercicioWidget(entrenamiento: alimento),
                    ],
                  ),
                );
              }),

              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   decoration: BoxDecoration(
              //       color: Colors.grey[200],
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Image.asset(
              //         'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
              //         width: 40,
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text('Levantamiento de pesas'),
              //           const SizedBox(height: 15),
              //           Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Image.asset(
              //                 'assets/icons/icono_calorias_negro_99x117_nuevo.png',
              //                 width: 15,
              //               ),
              //               const SizedBox(width: 8),
              //               Text(
              //                 '487 Calorías',
              //                 style: TextStyle(fontWeight: FontWeight.bold),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(height: 15),
              //           Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Image.asset(
              //                 'assets/icons/icono_intensidad_negro_38x24_nuevo.png',
              //                 width: 15,
              //               ),
              //               const SizedBox(width: 8),
              //               Text('Intensidad: Ligero'),
              //             ],
              //           )
              //         ],
              //       ),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           Container(
              //             padding: EdgeInsets.all(5),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Text(
              //               '8:24 a.m.',
              //               style: TextStyle(fontSize: 10),
              //             ),
              //           ),
              //           const SizedBox(height: 50),
              //           Container(
              //             padding: EdgeInsets.all(5),
              //             child: Row(
              //               children: [
              //                 Image.asset(
              //                     'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
              //                     width: 15),
              //                 SizedBox(width: 8),
              //                 Text(
              //                   '90 min.',
              //                   style: TextStyle(fontSize: 10),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox calendario(WeeklyCalendarController controller) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: controller.pageController,
        reverse: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          DateTime weekStart = controller.getWeekStartDate(index);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (dayIndex) {
              DateTime day = weekStart.add(Duration(days: dayIndex));
              // bool isFutureDay = controller.today.value.isAfter(day);

              return GestureDetector(
                onTap: () {
                  // if (!isFutureDay) {
                  controller.today.value = day;
                  controller.cargaAlimentos();
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Obx(() {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white54,
                          ),
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat.E('es')
                                  .format(day)
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                color: controller.today.value == day
                                    ? Colors.black
                                    : Colors.black54,
                                fontWeight: controller.today.value == day
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Número del día sin borde ni fondo
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: controller.today.value == day
                                ? Colors
                                    .black // Color del número cuando está seleccionado
                                : Colors.black26,
                            fontWeight: controller.today.value == day
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class SalesData {
  SalesData(DateTime dateTime, String s, double d, int i, int j, int k, int l);
}

class NutritionWidget extends StatelessWidget {
  final AlimentoModel nutritionInfo;

  // Constructor con un solo parámetro
  const NutritionWidget({super.key, required this.nutritionInfo});

  @override
  Widget build(BuildContext context) {
    double width = 210;
    return GestureDetector(
      onTap: () {
        Get.to(() => NutricionScreen(alimento: nutritionInfo));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 10, left: 10),
        width: width,
        // height: 350,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                if (nutritionInfo.imageUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${nutritionInfo.imageUrl}',
                      width: width,
                      height: 180,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator.adaptive(),
                    ),
                  )
                else
                  Container(
                    height: 30,
                  ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        '${nutritionInfo.name}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${nutritionInfo.calories} calorías', // Usamos el parámetro de las calorías
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _buildNutritionItem(
                        'assets/icons/icono_filetecarne_90x69_nuevo.png', // Ícono de proteínas
                        '${nutritionInfo.protein}gr.', // Usamos el parámetro de proteínas
                      ),
                      const SizedBox(height: 10),
                      _buildNutritionItem(
                        'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png', // Ícono de carbohidratos
                        '${nutritionInfo.carbs}gr', // Usamos el parámetro de carbohidratos
                      ),
                      const SizedBox(height: 10),
                      _buildNutritionItem(
                        'assets/icons/icono_almedraazul_74x70_nuevo.png', // Ícono de grasas
                        '${nutritionInfo.fats}gr.', // Usamos el parámetro de grasas
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  '${nutritionInfo.time}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String iconUrl, String value) {
    return Row(
      children: [
        Image.asset(
          iconUrl,
          width: 15,
          height: 15,
        ),
        const SizedBox(width: 8.0),
        Text(value),
        const SizedBox(width: 10),
      ],
    );
  }
}

class AjercicioWidget extends StatelessWidget {
  final AlimentoModel nutritionInfo;

  // Constructor con un solo parámetro
  const AjercicioWidget({super.key, required this.nutritionInfo});

  @override
  Widget build(BuildContext context) {
    double width = 210;
    return GestureDetector(
      onTap: () {
        Get.to(() => NutricionScreen(alimento: nutritionInfo));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 10, left: 10),
        width: width,
        // height: 350,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${nutritionInfo.imageUrl}',
                    width: width,
                    height: 180,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator.adaptive(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        '${nutritionInfo.name}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${nutritionInfo.calories} calorías', // Usamos el parámetro de las calorías
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _buildNutritionItem(
                        'assets/icons/icono_filetecarne_90x69_nuevo.png', // Ícono de proteínas
                        '${nutritionInfo.protein}gr.', // Usamos el parámetro de proteínas
                      ),
                      const SizedBox(height: 10),
                      _buildNutritionItem(
                        'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png', // Ícono de carbohidratos
                        '${nutritionInfo.carbs}gr', // Usamos el parámetro de carbohidratos
                      ),
                      const SizedBox(height: 10),
                      _buildNutritionItem(
                        'assets/icons/icono_almedraazul_74x70_nuevo.png', // Ícono de grasas
                        '${nutritionInfo.fats}gr.', // Usamos el parámetro de grasas
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  '${nutritionInfo.time}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String iconUrl, String value) {
    return Row(
      children: [
        Image.asset(
          iconUrl,
          width: 15,
          height: 15,
        ),
        const SizedBox(width: 8.0),
        Text(value),
        const SizedBox(width: 10),
      ],
    );
  }
}

class EjercicioWidget extends StatelessWidget {
  final Entrenamiento entrenamiento;

  // Constructor con un solo parámetro
  const EjercicioWidget({super.key, required this.entrenamiento});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CorrerScreen(
            entrenamiento: entrenamiento,
            id: entrenamiento.sId,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entrenamiento.nombre}'),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                      width: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${entrenamiento.calorias} Calorías',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/icono_intensidad_negro_38x24_nuevo.png',
                      width: 15,
                    ),
                    const SizedBox(width: 8),
                    Text('Intensidad: ${entrenamiento.intensidad}'),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${entrenamiento.time}.',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Image.asset(
                          'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
                          width: 15),
                      SizedBox(width: 8),
                      Text(
                        '${entrenamiento.tiempo} min.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String iconUrl, String value) {
    return Row(
      children: [
        Image.asset(
          iconUrl,
          width: 15,
          height: 15,
        ),
        const SizedBox(width: 8.0),
        Text(value),
        const SizedBox(width: 10),
      ],
    );
  }
}
