import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';

class HealthDataChart extends StatelessWidget {
  const HealthDataChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyCalendarController(), permanent: false);
    final controllerUsuario = Get.put(UsuarioController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [

        //     // Container(
        //     //   padding: const EdgeInsets.only(left: 15, top: 15),
        //     //   margin:
        //     //       const EdgeInsets.only(top: 0, left: 2, right: 0, bottom: 0),
        //     //   width: Get.width * 0.42,
        //     //   height: 225,
        //     //   decoration: BoxDecoration(
        //     //     color: Colors.white,
        //     //     borderRadius: BorderRadius.circular(20),
        //     //     boxShadow: [
        //     //       BoxShadow(
        //     //         color: Colors.black.withOpacity(0.08),
        //     //         blurRadius: 4.0,
        //     //         offset: Offset(0, 4),
        //     //       ),
        //     //     ],
        //     //   ),
        //     //   child: Column(
        //     //     crossAxisAlignment: CrossAxisAlignment.start,
        //     //     children: [
        //     //       Row(
        //     //         crossAxisAlignment: CrossAxisAlignment.start,
        //     //         spacing: 10,
        //     //         children: [
        //     //           Image.asset(
        //     //             'assets/icons/icono_calorias_negro_99x117_nuevo.png',
        //     //             width: 15,
        //     //           ),
        //     //           Obx(
        //     //             () => Text(
        //     //               '${controller.caloriasQuemadas}',
        //     //               style: TextStyle(
        //     //                 fontWeight: FontWeight.w700,
        //     //               ),
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       ),
        //     //       Row(
        //     //         crossAxisAlignment: CrossAxisAlignment.start,
        //     //         children: [
        //     //           SizedBox(width: 20),
        //     //           Text(
        //     //             'Calorías quemadas',
        //     //             style: TextStyle(
        //     //               fontSize: 10,
        //     //               fontWeight: FontWeight.w700,
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       ),
        //     //       const SizedBox(height: 10),
        //     //       Row(
        //     //         crossAxisAlignment: CrossAxisAlignment.start,
        //     //         spacing: 10,
        //     //         children: [
        //     //           Image.asset(
        //     //             'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
        //     //             width: 20,
        //     //           ),
        //     //           Text(
        //     //             'Pasos',
        //     //             style: TextStyle(
        //     //               fontSize: 10,
        //     //               fontWeight: FontWeight.w700,
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       ),
        //     //       Row(
        //     //         crossAxisAlignment: CrossAxisAlignment.start,
        //     //         children: [
        //     //           SizedBox(width: 30),
        //     //           Obx(
        //     //             () => Text(
        //     //               '+${controller.pasos}',
        //     //               style: TextStyle(
        //     //                 fontWeight: FontWeight.w700,
        //     //               ),
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       ),
        //     //       Obx(
        //     //         () => controller.levantamientoPesass > 0
        //     //             ? Column(
        //     //                 children: [
        //     //                   const SizedBox(height: 10),
        //     //                   Row(
        //     //                     crossAxisAlignment: CrossAxisAlignment.start,
        //     //                     children: [
        //     //                       Image.asset(
        //     //                         'assets/icons/icono_registrar_ejercicio_solido_180x180_pesas.png',
        //     //                         width: 20,
        //     //                       ),
        //     //                       const SizedBox(width: 10),
        //     //                       const Text(
        //     //                         'Pesas',
        //     //                         style: TextStyle(
        //     //                           fontSize: 10,
        //     //                           fontWeight: FontWeight.w700,
        //     //                         ),
        //     //                       ),
        //     //                     ],
        //     //                   ),
        //     //                   Row(
        //     //                     crossAxisAlignment: CrossAxisAlignment.start,
        //     //                     children: [
        //     //                       const SizedBox(width: 30),
        //     //                       Text(
        //     //                         '+${controller.levantamientoPesass}',
        //     //                         style: const TextStyle(
        //     //                           fontWeight: FontWeight.w700,
        //     //                         ),
        //     //                       ),
        //     //                     ],
        //     //                   ),
        //     //                 ],
        //     //               )
        //     //             : const SizedBox.shrink(),
        //     //       ),
        //     //       Obx(
        //     //         () => controller.otro > 0
        //     //             ? Column(
        //     //                 children: [
        //     //                   const SizedBox(height: 10),
        //     //                   Row(
        //     //                     crossAxisAlignment: CrossAxisAlignment.start,
        //     //                     children: [
        //     //                       Image.asset(
        //     //                         'assets/icons/icono_registrar_ejercicio_solido_180x180_anotar.png',
        //     //                         width: 20,
        //     //                       ),
        //     //                       const SizedBox(width: 10),
        //     //                       const Text(
        //     //                         'Otros',
        //     //                         style: TextStyle(
        //     //                           fontSize: 10,
        //     //                           fontWeight: FontWeight.w700,
        //     //                         ),
        //     //                       ),
        //     //                     ],
        //     //                   ),
        //     //                   Row(
        //     //                     crossAxisAlignment: CrossAxisAlignment.start,
        //     //                     children: [
        //     //                       const SizedBox(width: 30),
        //     //                       Text(
        //     //                         '+${controller.otro}',
        //     //                         style: const TextStyle(
        //     //                           fontWeight: FontWeight.w700,
        //     //                         ),
        //     //                       ),
        //     //                     ],
        //     //                   ),
        //     //                 ],
        //     //               )
        //     //             : const SizedBox.shrink(),
        //     //       ),
        //     //     ],
        //     //   ),
        //     // ),
        //   ],
        // ),

        Container(
          alignment: Alignment.center,
          width: Get.width,
          margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 0),
          height: 225,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/icono_registrar_ejercicio_68x68_correr.png',
                      width: 22,
                      color: blackTheme_,
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => Text(
                        '${controller.pasosHoy.toInt()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => Text(
                        'Pasos del día ${controller.daysOfWeek[controller.today.value.weekday - 1]}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: blackThemeText),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 4, right: 4),
                height: 140,
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : BarChart(
                          BarChartData(
                            barGroups: controller.charSorce
                                .asMap()
                                .entries
                                .map(
                                  (entry) =>
                                      BarChartGroupData(x: entry.key, barRods: [
                                    BarChartRodData(
                                      toY: entry.value.value,
                                      color: blackTheme_,
                                      width: 16,
                                      borderRadius: BorderRadius.circular(8),
                                      backDrawRodData:
                                          BackgroundBarChartRodData(
                                        show: true,
                                        toY: controller.maximo.value.toDouble(),
                                        color: greyTheme_,
                                      ),
                                    )
                                  ]),
                                )
                                .toList(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    reservedSize: 40, showTitles: false),
                              ),
                              show: true,
                              topTitles: AxisTitles(
                                  drawBelowEverything: false, axisNameSize: 10),
                              rightTitles:
                                  AxisTitles(drawBelowEverything: true),
                              bottomTitles: AxisTitles(
                                drawBelowEverything: true,
                                axisNameSize: 12,
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
                        ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: Get.width,
          margin: const EdgeInsets.only(
            left: 2,
            right: 2,
          ),
          padding: const EdgeInsets.all(25),
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
          child: Column(
            spacing: 10,
            children: [
              Row(
                spacing: 15,
                children: [
                  Image.asset(
                    'assets/icons/icono_corazon_24x24_2025.png',
                    width: 20,
                  ),
                  Text(
                    'Puntuación de salud',
                    style: TextStyle(
                      color: blackThemeText,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${controllerUsuario.usuario.value.puntuacionSalud!}/10',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: blackTheme_),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: LinearProgressIndicator(
                  value: controllerUsuario.usuario.value.puntuacionSalud! / 10,
                  color: blackTheme_,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: greyTheme_,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
