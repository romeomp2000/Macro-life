import 'package:macrolife/models/ingrediente.model.dart';
import 'package:macrolife/screen/IngredientesEditar/controller.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IngredienteEditarScreen extends StatelessWidget {
  final IngredienteModel ingrediente;
  const IngredienteEditarScreen({super.key, required this.ingrediente});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IngredientesEditarController());
    controller.ingrediente.value = ingrediente;

    controller.calorias.text = ingrediente.calorias.toString();

    controller.protinae.text = ingrediente.proteina.toString();

    controller.carbohidratos.text = ingrediente.carbohidratos.toString();

    controller.grasas.text = ingrediente.grasas.toString();

    controller.chartData.value = [
      ChartData(
          'Proteínas', ingrediente.proteina!.toDouble(), Colors.redAccent),
      ChartData(
          'Grasas', ingrediente.grasas!.toDouble(), const Color(0xFFE69938)),
      ChartData('Carbohidratos', ingrediente.carbohidratos!.toDouble(),
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
        title: const Text(
          'Editar ingredientes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.grey[200],
            ),
            child: IconButton(
              onPressed: () => controller.eliminarIngrediente(),
              icon: const Icon(Icons.delete_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  '${ingrediente.nombre}',
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
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
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
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
                    'Calorías',
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
                              color: Colors.red,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
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
                              color: Colors.orange,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
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
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
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
                      'Guardar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
