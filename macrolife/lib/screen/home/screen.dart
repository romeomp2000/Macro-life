import 'dart:io';
import 'package:flutter_slidable_plus_plus/flutter_slidable_plus_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/correr/controller.dart';
import 'package:macrolife/screen/correr/screen.dart';
import 'package:macrolife/screen/ejercicio_describir/controller.dart';
import 'package:macrolife/screen/ejercicio_describir/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/nutricion/controller.dart';
import 'package:macrolife/screen/nutricion/screen.dart';
import 'package:macrolife/screen/pesas/controller.dart';
import 'package:macrolife/screen/pesas/screen.dart';
import 'package:macrolife/widgets/AppleHealth.dart';
import 'package:macrolife/widgets/NutrientIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget puntuaciones(UsuarioController controllerUsuario) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('/objetivos'),
          child: Container(
            margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: Get.width,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controllerUsuario.macronutrientes.value
                                              .caloriasRestantes !=
                                          null &&
                                      controllerUsuario.macronutrientes.value
                                              .caloriasRestantes! <
                                          0
                                  ? '${controllerUsuario.macronutrientes.value.caloriasRestantes!.abs()}'
                                  : '${controllerUsuario.macronutrientes.value.caloriasRestantes ?? 0}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controllerUsuario.macronutrientes.value
                                              .caloriasRestantes !=
                                          null &&
                                      controllerUsuario.macronutrientes.value
                                              .caloriasRestantes! <
                                          0
                                  ? 'Calorías más'
                                  : 'Calorías\nrestantes',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: Obx(() => CircularPercentIndicator(
                              radius: 55.0,
                              lineWidth: 8.0,
                              percent: (controllerUsuario
                                  .macronutrientes.value.caloriasPorcentaje!
                                  .toDouble()),
                              center: const Icon(Icons.local_fire_department),
                              progressColor: Colors.black, // Color del progreso
                              backgroundColor:
                                  Colors.black12, // Color del fondo del círculo
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 50,
                    bottom: 0,
                    top: 50,
                    child: Obx(
                      () => Column(
                        spacing: 0,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (controllerUsuario
                                      .macronutrientes.value.caloriasQuemadas !=
                                  null &&
                              controllerUsuario
                                      .macronutrientes.value.caloriasQuemadas !=
                                  0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: (controllerUsuario.macronutrientes.value
                                              .caloriasQuemadas ??
                                          0) >
                                      1000
                                  ? 76
                                  : 72,
                              child: Row(
                                spacing: 5,
                                children: [
                                  Image.asset(
                                    'assets/icons/icono_cajon_ejercicio_88x88_registrar.png',
                                    width: 12,
                                  ),
                                  Text(
                                    '+${controllerUsuario.macronutrientes.value.caloriasQuemadas}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            .macronutrientes.value.carbohidratosPorcentaje
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();

    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController());

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/background_1125x2436_uno.jpg'), // Ruta de la imagen
          fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
        ),
        borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Image.asset(
                        'assets/icons/logo_macro_life_1125x207.png',
                        width: 155,
                      ),
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
                calendario(controller),
                SizedBox(
                  height: 318,
                  child: PageView(
                    onPageChanged: (value) {
                      if (value == 0) {
                        controller.verAppleHealth.value = false;
                      }
                      if (value == 1) {
                        controller.verAppleHealth.value = true;
                      }
                    },
                    controller: PageController(),
                    children: [
                      puntuaciones(controllerUsuario),
                      if (GetPlatform.isIOS) HealthDataChart()
                    ],
                  ),
                ),

                Obx(() {
                  if (Platform.isIOS) {
                    return Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.verAppleHealth.value == false)
                          Icon(Icons.circle, size: 10)
                        else
                          Icon(Icons.circle_outlined, size: 10),
                        if (controller.verAppleHealth.value == true)
                          Icon(Icons.circle, size: 10)
                        else
                          Icon(Icons.circle_outlined, size: 10),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'Registros recientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => controller.alimentosList.isEmpty &&
                          controller.entrenamientosList.isEmpty
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '¡No has subido ninguna comida!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width - 100,
                                      child: Text(
                                        'Comienza a registrar las comidas de tu día tomando una foto rápida',
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
                              right: 70,
                              bottom: -25,
                              child: Image.asset(
                                'assets/icons/flecha_comida_113x149_negro.png',
                                width: 30,
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),

                Obx(() {
                  return controller.loader.value
                      ? const LinearProgressIndicator()
                      : const SizedBox
                          .shrink(); // O cualquier widget vacío que desees
                }),
                Obx(() {
                  return SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var alimento in controller.alimentosList)
                          NutritionWidget(nutritionInfo: alimento),
                      ],
                    ),
                  );
                }),
                Obx(() {
                  return SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        for (var alimento in controller.entrenamientosList)
                          EjercicioWidget(entrenamiento: alimento),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 50),

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
      ),
    );
  }

  Container calendario(WeeklyCalendarController controller) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
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
              DateTime dayActual = DateTime.now();
              return GestureDetector(
                onTap: () {
                  if (day.isAfter(dayActual)) {
                    return;
                  }
                  controller.today.value = day;
                  controller.cargaAlimentos();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Obx(() {
                    bool isSelected =
                        controller.isSameDay(controller.today.value, day);

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? Colors.black : Colors.white54,
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
                                color:
                                    isSelected ? Colors.white : Colors.black54,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Número del día
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.black54,
                            fontWeight: isSelected
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
    return GestureDetector(
      onTap: () {
        Get.to(() => NutricionScreen(alimento: nutritionInfo));
      },
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onPressed: (context) {
                final NutricionController controller =
                    Get.put((NutricionController()));
                controller.alimento.value = nutritionInfo;
                controller.deleteAlimento();
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              label: 'Eliminar',
            ),
          ],
        ),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nutritionInfo.imageUrl != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '${nutritionInfo.imageUrl}',
                        width: 120,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox.shrink(),
                          SizedBox(
                            width: Get.width - 225,
                            child: Text(
                              FuncionesGlobales.capitalize(
                                  nutritionInfo.name ?? ''),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Muestra tres puntos cuando el texto no cabe
                              maxLines: 1, // Limita a una línea
                            ),
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Image.asset(
                                'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                                width: 15,
                                height: 15,
                              ),
                              Text(
                                '${nutritionInfo.calories} calorías',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 12,
                            children: [
                              _buildNutritionItem(
                                'assets/icons/icono_filetecarne_90x69_nuevo.png',
                                '${nutritionInfo.protein}g', // Usamos el parámetro de proteínas
                              ),
                              _buildNutritionItem(
                                'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                                '${nutritionInfo.carbs}g', // Usamos el parámetro de carbohidratos
                              ),
                              _buildNutritionItem(
                                'assets/icons/icono_almedraazul_74x70_nuevo.png',
                                '${nutritionInfo.fats}g', // Usamos el parámetro de grasas
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
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
      ),
    );
  }

  Widget _buildNutritionItem(String iconUrl, String value) {
    return Row(
      spacing: 8,
      children: [
        Image.asset(
          iconUrl,
          width: 15,
          height: 15,
        ),
        Text(value, style: TextStyle(fontSize: 13)),
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
                            '${nutritionInfo.calories} calorías',
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
  const EjercicioWidget({super.key, required this.entrenamiento});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (entrenamiento.descripcion != null) {
          Get.to(
            () => EjercicioDescribirScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
          return;
        }

        if (entrenamiento.nombre == 'Levantamiento de pesas') {
          Get.to(
            () => PesasScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
        } else {
          Get.to(
            () => CorrerScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
        }
      },
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onPressed: (context) {
                if (entrenamiento.descripcion != null) {
                  final controller = Get.put(EjercicioDescribirController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                }

                if (entrenamiento.nombre == 'Levantamiento de pesas') {
                  final controller = Get.put(PesasController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                } else {
                  final controller = Get.put(CorrerController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                }
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              label: 'Eliminar',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                entrenamiento.descripcion != null
                    ? 'assets/icons/icono_registrar_ejercicio_solido_180x180_anotar.png'
                    : entrenamiento.nombre == 'Levantamiento de pesas'
                        ? 'assets/icons/icono_registrar_ejercicio_solido_180x180_pesas.png'
                        : 'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
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
      ),
    );
  }
}
