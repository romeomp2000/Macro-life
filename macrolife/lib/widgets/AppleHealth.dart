import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';

class HealthDataChart extends StatelessWidget {
  const HealthDataChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyCalendarController());
    final controllerUsuario = Get.put(UsuarioController());
    return Column(
      spacing: 20,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * 0.45,
              margin:
                  const EdgeInsets.only(top: 5, left: 2, right: 2, bottom: 0),
              height: 230,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Image.asset(
                              'assets/icons/icono_registrar_ejercicio_68x68_correr.png',
                              width: 22,
                            ),
                            Obx(
                              () => Text(
                                '${controller.pasosHoy.toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Text(
                              'Pasos de hoy',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 1),
                    height: 150,
                    child: Obx(() => controller.isLoading.value
                            ? Center(
                                child:
                                    CircularProgressIndicator(), // Muestra un indicador de carga
                              )
                            : BarChart(
                                BarChartData(
                                  barGroups: controller.charSorce
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => BarChartGroupData(
                                          x: entry.key,
                                          barRods: [
                                            BarChartRodData(
                                              toY: entry.value.value,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                              width: 17,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    leftTitles: AxisTitles(
                                      drawBelowEverything: false,
                                    ),
                                    topTitles:
                                        AxisTitles(drawBelowEverything: false),
                                    rightTitles:
                                        AxisTitles(drawBelowEverything: false),
                                    bottomTitles: AxisTitles(
                                      drawBelowEverything: true,
                                      axisNameSize: 10,
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            controller.getTitles(value, meta),
                                      ),
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: false,
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  barTouchData: BarTouchData(
                                    enabled: false,
                                  ),
                                ),
                              )
                        // SfCartesianChart(
                        //     primaryYAxis: NumericAxis(
                        //       isVisible: false,
                        //     ),
                        //     // borderColor: Colors.black,
                        //     plotAreaBackgroundColor: Colors.transparent,
                        //     primaryXAxis: CategoryAxis(
                        //         // borderWidth: 0,
                        //         // maximumLabelWidth: 22,

                        //         ),
                        //     series: <CartesianSeries>[
                        //       // Inicializa la serie de columnas (barras)
                        //       ColumnSeries<ChartData, String>(
                        //         dataSource: controller.charSorce,
                        //         width: 0.3,
                        //         color: Colors.black,
                        //         xValueMapper: (ChartData data, _) =>
                        //             data.label,
                        //         yValueMapper: (ChartData data, _) =>
                        //             data.value,
                        //       )
                        //     ],
                        //   ),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, top: 10),
              margin:
                  const EdgeInsets.only(top: 5, left: 2, right: 2, bottom: 0),
              width: Get.width * 0.45,
              height: 230,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                        width: 15,
                      ),
                      Obx(
                        () => Text(
                          '${controller.caloriasQuemadas}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Calorías quedamadas',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
                        width: 20,
                      ),
                      Text(
                        'Pasos',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 30),
                      Obx(
                        () => Text(
                          '+${controller.pasos}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => controller.levantamientoPesass > 0
                        ? Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/icons/icono_registrar_ejercicio_solido_180x180_pesas.png',
                                    width: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Pesas',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 30),
                                  Text(
                                    '+${controller.levantamientoPesass}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.otro > 0
                        ? Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/icons/icono_registrar_ejercicio_solido_180x180_anotar.png',
                                    width: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Otros',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 30),
                                  Text(
                                    '+${controller.otro}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: Get.width,
          margin: const EdgeInsets.only(
            left: 2,
            right: 2,
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0.1,
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/icono_corazonrosa_50x50_nuevo.png',
                    width: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      const Text('Puntuación de salud'),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: Get.width - 110,
                        child: LinearProgressIndicator(
                          value:
                              controllerUsuario.usuario.value.puntuacionSalud! /
                                  10,
                          color: Colors.black,
                          backgroundColor: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  '${controllerUsuario.usuario.value.puntuacionSalud!}/10',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
