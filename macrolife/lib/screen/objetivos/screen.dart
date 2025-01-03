import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
                        // width: 300,
                        child: SfCartesianChart(
                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 100,
                            interval: 50,
                            opposedPosition: true,
                            borderColor: Colors.black12,
                          ),
                          plotAreaBackgroundColor: Colors.transparent,
                          primaryXAxis: CategoryAxis(),
                          enableSideBySideSeriesPlacement: false,
                          series: <CartesianSeries>[
                            // Inicializa la serie de columnas (barras)
                            ColumnSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Calorías', 100, Colors.white)
                              ],
                              width: 0.25,
                              color: Colors.black,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
                            ),
                            ColumnSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Proteína', 70, Colors.white)
                              ],
                              width: 0.25,
                              color: Colors.red,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
                            ),
                            ColumnSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Carbohidratos', 50, Colors.white)
                              ],
                              width: 0.25,
                              color: Colors.orange,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
                            ),
                            ColumnSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Grasas', 25, Colors.white)
                              ],
                              width: 0.25,
                              color: Colors.blue,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CupertinoListTile(
                      leadingSize: 80,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: SfCartesianChart(
                              primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 100,
                                interval: 50,
                                opposedPosition: true,
                                borderColor: Colors.black12,
                                isVisible: false,
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
                                    ChartData('', 50, Colors.white),
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
                          Image.asset(
                            'assets/icons/icono_calorias_negro_99x117_nuevo.png',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: SfCartesianChart(
                              primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 100,
                                interval: 50,
                                opposedPosition: true,
                                borderColor: Colors.black12,
                                isVisible: false,
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
                                    ChartData('', 50, Colors.white),
                                  ],
                                  width: 1,
                                  color: Colors.red,
                                  xValueMapper: (ChartData data, _) =>
                                      data.label,
                                  yValueMapper: (ChartData data, _) =>
                                      data.value,
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/icons/icono_filetecarne_90x69_nuevo.png',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: SfCartesianChart(
                              primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 100,
                                interval: 50,
                                opposedPosition: true,
                                borderColor: Colors.black12,
                                isVisible: false,
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
                                    ChartData('', 50, Colors.white),
                                  ],
                                  width: 1,
                                  color: Colors.orange,
                                  xValueMapper: (ChartData data, _) =>
                                      data.label,
                                  yValueMapper: (ChartData data, _) =>
                                      data.value,
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
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
                      leadingSize: 70,
                      padding: EdgeInsets.zero,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 40,
                            child: SfCartesianChart(
                              primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 100,
                                interval: 50,
                                opposedPosition: true,
                                borderColor: Colors.black12,
                                isVisible: false,
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
                                    ChartData('', 50, Colors.white),
                                  ],
                                  width: 1,
                                  color: Colors.blue,
                                  xValueMapper: (ChartData data, _) =>
                                      data.label,
                                  yValueMapper: (ChartData data, _) =>
                                      data.value,
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/icons/icono_almedraazul_74x70_nuevo.png',
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
