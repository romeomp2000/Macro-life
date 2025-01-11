import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:macrolife/models/ingrediente.model.dart';
import 'package:macrolife/screen/IngredientesEditar/controller.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:pull_down_button/pull_down_button.dart';

class IngredienteEditarScreen extends StatelessWidget {
  final IngredienteModel ingrediente;
  const IngredienteEditarScreen({super.key, required this.ingrediente});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IngredientesEditarController());
    controller.ingrediente.value = ingrediente;

    controller.calorias.text = (ingrediente.calorias?.floor().toString() ?? '');

    controller.protinae.text = (ingrediente.proteina?.floor().toString() ?? '');

    controller.carbohidratos.text =
        (ingrediente.carbohidratos?.floor().toString() ?? '');

    controller.grasas.text = (ingrediente.grasas?.floor().toString() ?? '');

    controller.chartData.value = [
      ChartData('Proteínas', ingrediente.proteina!.toDouble(), Colors.black),
      ChartData('Grasas', ingrediente.grasas!.toDouble(), Colors.black),
      ChartData(
          'Carbohidratos', ingrediente.carbohidratos!.toDouble(), Colors.black)
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: true,
      // bottomNavigationBar:
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Editar ingredientes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PullDownButton(
            routeTheme: PullDownMenuRouteTheme(
              borderRadius: BorderRadius.circular(15),
            ),
            itemBuilder: (context) => [
              PullDownMenuItem(
                onTap: () {
                  controller.eliminarIngrediente();
                },
                title: 'Eliminar ingrediente',
                isDestructive: true,
                icon: Icons.delete_outline_outlined,
              ),
            ],
            buttonBuilder: (context, showMenu) => CupertinoButton(
              onPressed: showMenu,
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(30)),
              padding: EdgeInsets.all(10),
              child: const Icon(
                Icons.more_horiz_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              '${ingrediente.nombre}',
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35),
            CupertinoListTile(
              leadingSize: 70,
              padding: EdgeInsets.zero,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    width: 40,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                toY: 50,
                                fromY: 0,
                                color: Colors.black,
                                width: 20,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          show: false,
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(drawBelowEverything: false),
                          topTitles: AxisTitles(drawBelowEverything: false),
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
                  Image.asset(
                    'assets/icons/icono_calorias_outline_120x120_activo.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              title: const Text(
                'Calorías',
                style: TextStyle(
                  // fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black38,
                ),
              ),
              trailing: Icon(Icons.edit, color: Colors.black87),
              subtitle: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')), // Permite solo números enteros
                ],
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
              leadingSize: 70,
              padding: EdgeInsets.zero,
              trailing: Icon(Icons.edit, color: Colors.black87),
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    width: 40,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                toY: 50,
                                fromY: 0,
                                color: Colors.black,
                                width: 20,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          show: false,
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(drawBelowEverything: false),
                          topTitles: AxisTitles(drawBelowEverything: false),
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
              leadingSize: 70,
              trailing: Icon(Icons.edit, color: Colors.black87),
              padding: EdgeInsets.zero,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    width: 40,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                toY: 50,
                                fromY: 0,
                                color: Colors.black,
                                width: 20,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          show: false,
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(drawBelowEverything: false),
                          topTitles: AxisTitles(drawBelowEverything: false),
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
              leadingSize: 70,
              padding: EdgeInsets.zero,
              trailing: Icon(Icons.edit, color: Colors.black87),
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    width: 40,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                toY: 50,
                                fromY: 0,
                                color: Colors.black,
                                width: 20,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          show: false,
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(drawBelowEverything: false),
                          topTitles: AxisTitles(drawBelowEverything: false),
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
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              width: Get.width,
              child: CustomElevatedButton(
                message: 'Guardar',
                function: () => controller.editarIngrediente(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
