import 'package:fl_chart/fl_chart.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
        title: const Text('Ajustar objetivos',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: const Text(
                      'Macronutrientes',
                      style:
                          TextStyle(fontSize: 33, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Obx(
                        () => PieChart(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInBack,
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                value: controller.pro.value,
                                showTitle: false,
                                color: redTheme_,
                                radius: 10,
                                badgeWidget: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 3, top: 3),
                                  decoration: BoxDecoration(
                                    color: redTheme_,
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
                                color: yellowTheme_,
                                radius: 10,
                                showTitle: false,
                                badgeWidget: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 3, top: 3),
                                  decoration: BoxDecoration(
                                    color: yellowTheme_,
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
                                color: blueTheme_,
                                radius: 10,
                                badgeWidget: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 3, top: 3),
                                  decoration: BoxDecoration(
                                    color: blueTheme_,
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
                  const SizedBox(height: 50),
                  CupertinoListTile(
                    // minLeadingWidth: 80,
                    leadingSize: 64,
                    leading: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: 0.50,
                      center: Image.asset(
                        'assets/icons/icono_flama_original_54x54_activo.png',
                        width: 15,
                      ),
                      progressColor: Colors.black, // Color del progreso
                      backgroundColor:
                          Colors.black12, // Color del fondo del círculo
                    ),
                    title: const Text(
                      'Meta calorías',
                      style: TextStyle(
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
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CupertinoListTile(
                    // minLeadingWidth: 80,
                    leadingSize: 64,
                    leading: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: 0.50,
                      center: Image.asset(
                          'assets/icons/icono_filetecarne_90x69_nuevo_1.png',
                          width: 15),
                      progressColor: redTheme_, // Color del progreso
                      backgroundColor:
                          Colors.black12, // Color del fondo del círculo
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
                    // minLeadingWidth: 80,
                    leadingSize: 64,
                    leading: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: 0.50,
                      center: Image.asset(
                          'assets/icons/icono_panintegral_amarillo_76x70_nuevo_1.png',
                          width: 15),
                      progressColor: yellowTheme_,
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
                    // minLeadingWidth: 80,
                    leadingSize: 64,
                    leading: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: 0.50,
                      center: Image.asset(
                          'assets/icons/icono_almedraazul_74x70_nuevo_1.png',
                          width: 15),
                      progressColor: blueTheme_,
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
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ObjetivosAutoScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                      ),
                      child: const Text(
                        "Generar objetivos automáticamente",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
