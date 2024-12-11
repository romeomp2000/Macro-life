import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
          icon: Image.network(
            'https://macrolife.app/images/app/home/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => {controller.back()},
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
                    SizedBox(
                      height: 180,
                      child: SfCircularChart(
                        annotations: const <CircularChartAnnotation>[
                          // Ícono central
                          CircularChartAnnotation(
                            widget: Icon(
                              Icons.local_fire_department,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                        series: <DoughnutSeries<ChartData, String>>[
                          DoughnutSeries<ChartData, String>(
                            dataSource: controller.chartData,
                            xValueMapper: (ChartData data, _) => data.label,
                            yValueMapper: (ChartData data, _) => data.value,
                            pointColorMapper: (ChartData data, _) => data.color,
                            radius: '60%', // Tamaño del anillo
                            innerRadius: '80%', // Grosor del anillo
                            // Personalización de etiquetas
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                ChartData chartData = data;
                                return Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: chartData
                                        .color, // Fondo del color del segmento
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${chartData.value.toInt()} g', // Texto personalizado
                                    style: const TextStyle(
                                      color: Colors.white, // Letras blancas
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoListTile(
                      leadingSize: 67,
                      padding: EdgeInsets.zero,
                      leading: CircularPercentIndicator(
                        radius: 33.0,
                        lineWidth: 5.0,
                        percent: 0.5,
                        center: const Icon(
                          Icons.local_fire_department,
                          size: 20,
                          color: Colors.black,
                        ),
                        progressColor: Colors.black,
                        backgroundColor: Colors.black12,
                      ),
                      title: const Text(
                        'Meta calórica',
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
                      leadingSize: 67,
                      padding: EdgeInsets.zero,
                      leading: CircularPercentIndicator(
                        radius: 33.0,
                        lineWidth: 5.0,
                        percent: 0.5,
                        center: Image.network(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png',
                          width: 15,
                        ),
                        progressColor: Colors.redAccent,
                        backgroundColor: Colors.black12,
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
                      leadingSize: 67,
                      padding: EdgeInsets.zero,
                      leading: CircularPercentIndicator(
                        radius: 33.0,
                        lineWidth: 5.0,
                        percent: 0.5,
                        center: Image.network(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png',
                          width: 15,
                        ),
                        progressColor: const Color(0xFFE69938),
                        backgroundColor: Colors.black12,
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
                      leadingSize: 67,
                      padding: EdgeInsets.zero,
                      leading: CircularPercentIndicator(
                        radius: 33.0,
                        lineWidth: 5.0,
                        percent: 0.5,
                        center: Image.network(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png',
                          width: 15,
                        ),
                        progressColor: Colors.blueAccent,
                        backgroundColor: Colors.black12,
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
