import 'package:fl_chart/fl_chart.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class ObjetivosScreen extends StatelessWidget {
  const ObjetivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ObjetivosController controller = Get.put(ObjetivosController());
    final UsuarioController controllerUsuario = Get.find();
    final WeeklyCalendarController controllerCalendar = Get.find();

    controller.calorias.text = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.calorias
            .toString() ??
        '';

    controller.protinae.text = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.proteina
            .toString() ??
        '';

    controller.carbohidratos.text = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.carbohidratos
            .toString() ??
        '';

    controller.grasas.text = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.grasas
            .toString() ??
        '';

    controller.chartData.value = [
      ChartData(
          'Proteínas',
          controllerUsuario.usuario.value.macronutrientesDiario?.value.proteina
                  ?.toDouble() ??
              0,
          Colors.redAccent),
      ChartData(
        'Grasas',
        controllerUsuario
                .usuario.value.macronutrientesDiario?.value.carbohidratos
                ?.toDouble() ??
            0,
        const Color(0xFFE69938),
      ),
      ChartData(
          'Carbohidratos',
          controllerUsuario.usuario.value.macronutrientesDiario?.value.grasas
                  ?.toDouble() ??
              0,
          Colors.blueAccent)
    ];

    controller.pro.value = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.proteina
            ?.toDouble() ??
        0.0;

    controller.gra.value = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.grasas
            ?.toDouble() ??
        0.0;

    controller.car.value = controllerUsuario
            .usuario.value.macronutrientesDiario?.value.carbohidratos
            ?.toDouble() ??
        0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text('Ajustar objetivos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Macronutrientes',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: SizedBox(
                        height: 150,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Obx(
                            () => PieChart(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInBack,
                              PieChartData(
                                sectionsSpace: 0,
                                centerSpaceRadius: 60,
                                sections: [
                                  PieChartSectionData(
                                    value: controller.pro.value,
                                    showTitle: false,
                                    color: Colors.black38,
                                    radius: 15,
                                    badgeWidget: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 3,
                                          top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        '${controller.pro.toInt()}g',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    badgePositionPercentageOffset: .98,
                                  ),
                                  PieChartSectionData(
                                    value: controller.car.value,
                                    color: Colors.black54,
                                    radius: 15,
                                    showTitle: false,
                                    badgeWidget: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 3,
                                          top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        '${controller.car.toInt()}g',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    badgePositionPercentageOffset: .98,
                                  ),
                                  PieChartSectionData(
                                    value: controller.gra.value,
                                    showTitle: false,
                                    color: Colors.black87,
                                    radius: 15,
                                    badgeWidget: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 3,
                                          top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        '${controller.gra.toInt()}g',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    badgePositionPercentageOffset: .98,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Center(
                    //   child: SizedBox(
                    //     height: 150,
                    //     // width: 300,
                    //     child: SfCartesianChart(
                    //       primaryYAxis: NumericAxis(
                    //         minimum: 0,
                    //         maximum: 100,
                    //         interval: 50,
                    //         opposedPosition: true,
                    //         borderColor: Colors.black12,
                    //       ),
                    //       plotAreaBackgroundColor: Colors.transparent,
                    //       primaryXAxis: CategoryAxis(),
                    //       enableSideBySideSeriesPlacement: false,
                    //       series: <CartesianSeries>[
                    //         // Inicializa la serie de columnas (barras)
                    //         ColumnSeries<ChartData, String>(
                    //           dataSource: [
                    //             ChartData('Calorías', 100, Colors.white)
                    //           ],
                    //           width: 0.25,
                    //           color: Colors.black,
                    //           xValueMapper: (ChartData data, _) => data.label,
                    //           yValueMapper: (ChartData data, _) => data.value,
                    //         ),
                    //         ColumnSeries<ChartData, String>(
                    //           dataSource: [
                    //             ChartData('Proteína', 70, Colors.white)
                    //           ],
                    //           width: 0.25,
                    //           color: Colors.red,
                    //           xValueMapper: (ChartData data, _) => data.label,
                    //           yValueMapper: (ChartData data, _) => data.value,
                    //         ),
                    //         ColumnSeries<ChartData, String>(
                    //           dataSource: [
                    //             ChartData('Carbohidratos', 50, Colors.white)
                    //           ],
                    //           width: 0.25,
                    //           color: Colors.orange,
                    //           xValueMapper: (ChartData data, _) => data.label,
                    //           yValueMapper: (ChartData data, _) => data.value,
                    //         ),
                    //         ColumnSeries<ChartData, String>(
                    //           dataSource: [
                    //             ChartData('Grasas', 25, Colors.white)
                    //           ],
                    //           width: 0.25,
                    //           color: Colors.blue,
                    //           xValueMapper: (ChartData data, _) => data.label,
                    //           yValueMapper: (ChartData data, _) => data.value,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                    CupertinoListTile(
                      leadingSize: 80,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: PieChart(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInBack,
                              PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 15,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.black,
                                      radius: 5,
                                    ),
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.grey.shade300,
                                      radius: 5,
                                    )
                                  ]),
                            ),
                            // SfCartesianChart(
                            //   primaryYAxis: NumericAxis(
                            //     minimum: 0,
                            //     maximum: 100,
                            //     interval: 50,
                            //     opposedPosition: true,
                            //     borderColor: Colors.black12,
                            //     isVisible: false,
                            //   ),
                            //   plotAreaBackgroundColor: Colors.black12,
                            //   primaryXAxis: CategoryAxis(
                            //     isVisible: false,
                            //   ),
                            //   enableSideBySideSeriesPlacement: false,
                            //   series: <CartesianSeries>[
                            //     // Inicializa la serie de columnas (barras)
                            //     ColumnSeries<ChartData, String>(
                            //       dataSource: [
                            //         // Fuente de datos
                            //         ChartData('', 50, Colors.white),
                            //       ],
                            //       width: 1,
                            //       color: Colors.black,
                            //       xValueMapper: (ChartData data, _) =>
                            //           data.label,
                            //       yValueMapper: (ChartData data, _) =>
                            //           data.value,
                            //     )
                            //   ],
                            // ),
                          ),
                          Image.asset(
                            'assets/icons/icono_calorias_outline_120x120_activo.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      title: const Text(
                        'Meta calorías',
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller.calorias,
                        onTap: () => controller.toggleKeyboardActions(true),
                        onEditingComplete: () =>
                            controller.toggleKeyboardActions(false),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(), // Borde cuando está enfocado
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CupertinoListTile(
                      leadingSize: 80,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            // margin: const EdgeInsets.only(right: 2),
                            width: 40,
                            child: PieChart(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInBack,
                              PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 15,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.black38,
                                      radius: 5,
                                    ),
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.grey.shade300,
                                      radius: 5,
                                    )
                                  ]),
                            ),
                            // SfCartesianChart(
                            //   primaryYAxis: NumericAxis(
                            //     minimum: 0,
                            //     maximum: 100,
                            //     interval: 50,
                            //     opposedPosition: true,
                            //     borderColor: Colors.black12,
                            //     isVisible: false,
                            //   ),
                            //   plotAreaBackgroundColor: Colors.black12,
                            //   primaryXAxis: CategoryAxis(
                            //     isVisible: false,
                            //   ),
                            //   enableSideBySideSeriesPlacement: false,
                            //   series: <CartesianSeries>[
                            //     // Inicializa la serie de columnas (barras)
                            //     ColumnSeries<ChartData, String>(
                            //       dataSource: [
                            //         // Fuente de datos
                            //         ChartData('', 50, Colors.white),
                            //       ],
                            //       width: 1,
                            //       color: Colors.red,
                            //       xValueMapper: (ChartData data, _) =>
                            //           data.label,
                            //       yValueMapper: (ChartData data, _) =>
                            //           data.value,
                            //     )
                            //   ],
                            // ),
                          ),
                          Image.asset(
                            'assets/icons/icono_filetecarne_outline_93x93_activo.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      title: const Text(
                        'Objetivo de proteína',
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.pro.value = double.parse(value);
                        },
                        controller: controller.protinae,
                        onTap: () => controller.toggleKeyboardActions(true),
                        onEditingComplete: () =>
                            controller.toggleKeyboardActions(false),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(), // Borde cuando está enfocado
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CupertinoListTile(
                      leadingSize: 80,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: PieChart(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInBack,
                              PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 15,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.black54,
                                      radius: 5,
                                    ),
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.grey.shade300,
                                      radius: 5,
                                    )
                                  ]),
                            ),
                            // SfCartesianChart(
                            //   primaryYAxis: NumericAxis(
                            //     minimum: 0,
                            //     maximum: 100,
                            //     interval: 50,
                            //     opposedPosition: true,
                            //     borderColor: Colors.black12,
                            //     isVisible: false,
                            //   ),
                            //   plotAreaBackgroundColor: Colors.black12,
                            //   primaryXAxis: CategoryAxis(
                            //     isVisible: false,
                            //   ),
                            //   enableSideBySideSeriesPlacement: false,
                            //   series: <CartesianSeries>[
                            //     // Inicializa la serie de columnas (barras)
                            //     ColumnSeries<ChartData, String>(
                            //       dataSource: [
                            //         // Fuente de datos
                            //         ChartData('', 50, Colors.white),
                            //       ],
                            //       width: 1,
                            //       color: Colors.orange,
                            //       xValueMapper: (ChartData data, _) =>
                            //           data.label,
                            //       yValueMapper: (ChartData data, _) =>
                            //           data.value,
                            //     )
                            //   ],
                            // ),
                          ),
                          Image.asset(
                            'assets/icons/icono_panintegral_outline_79x79_activo.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      title: const Text(
                        'Meta de carbohidratos',
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller.carbohidratos,
                        onChanged: (value) {
                          controller.car.value = double.parse(value);
                        },
                        onTap: () => controller.toggleKeyboardActions(true),
                        onEditingComplete: () =>
                            controller.toggleKeyboardActions(false),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(), // Borde cuando está enfocado
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CupertinoListTile(
                      leadingSize: 80,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: PieChart(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInBack,
                              PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 15,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.black87,
                                      radius: 5,
                                    ),
                                    PieChartSectionData(
                                      value: 50,
                                      showTitle: false,
                                      color: Colors.grey.shade300,
                                      radius: 5,
                                    )
                                  ]),
                            ),
                          ),
                          Image.asset(
                            'assets/icons/icono_almendra_outline_78x78_activo.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      title: const Text(
                        'Objetivo de grasas',
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                      subtitle: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller.grasas,
                        onChanged: (value) {
                          controller.gra.value = double.parse(value);
                        },
                        onTap: () => controller.toggleKeyboardActions(true),
                        onEditingComplete: () =>
                            controller.toggleKeyboardActions(false),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(), // Borde cuando está enfocado
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Container(
                    //   margin: const EdgeInsets.all(10),
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           Colors.white, // Color de fondo blanco
                    //       foregroundColor:
                    //           Colors.black, // Color del texto negro
                    //       side: const BorderSide(
                    //           color: Colors.black, width: 1.5), // Borde negro
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //             30.0), // Bordes redondeados
                    //       ),
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 12.0,
                    //         horizontal: 24.0,
                    //       ), // Espaciado interno
                    //     ),
                    //     child: const Text(
                    //       "Generar objetivos automáticamente",
                    //       style: TextStyle(
                    //         fontSize: 16.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            if (controller.showKeyboardActions.value) {
              return Container(
                color: Colors.grey[100],
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Revertir'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          controllerUsuario
                              .usuario
                              .value
                              .macronutrientesDiario
                              ?.value
                              .calorias = int.parse(controller.calorias.text),
                          controllerUsuario
                              .usuario
                              .value
                              .macronutrientesDiario
                              ?.value
                              .proteina = int.parse(controller.protinae.text),
                          controllerUsuario.usuario.value.macronutrientesDiario
                                  ?.value.carbohidratos =
                              int.parse(controller.carbohidratos.text),
                          controllerUsuario
                              .usuario
                              .value
                              .macronutrientesDiario
                              ?.value
                              .grasas = int.parse(controller.grasas.text),
                          FuncionesGlobales.actualizarMacronutrientes(),
                          controllerCalendar.refreshCantadorMacronutrientes(
                              controllerUsuario),
                          controller.showKeyboardActions.value = false,
                          Get.focusScope?.unfocus(),
                          controllerUsuario.usuario.refresh(),
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Hecho'),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox
                  .shrink(); // No mostrar nada si no está activo
            }
          }),
        ],
      ),
    );
  }
}
