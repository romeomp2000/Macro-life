import 'package:fl_chart/fl_chart.dart';
import 'package:macrolife/screen/EditarNutrientes/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarNutrientesScreen extends StatelessWidget {
  // final Color color;
  final String imageUrl;
  final String title;
  final String textField;
  final int initialValue;
  final Function(int) onSave;

  const EditarNutrientesScreen({
    super.key,
    // required this.color,
    required this.imageUrl,
    required this.title,
    required this.initialValue,
    required this.onSave,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarNutrientesController());

    controller.valueController.text = initialValue.toString();
    controller.text.value = initialValue.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {Get.back()},
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              width: Get.width,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black12, // Define el color del borde
                  width: 1.0, // Define el grosor del borde
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 85,
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
                                width: 35,
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
                            show: true,
                            leftTitles: AxisTitles(),
                            bottomTitles:
                                AxisTitles(drawBelowEverything: false),
                            topTitles: AxisTitles(drawBelowEverything: false)),
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
                    imageUrl,
                    width: 25,
                  )
                ],
              ),
            ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         CircularPercentIndicator(
            //           radius: 55.0,
            //           lineWidth: 5.0,
            //           percent: 0.5,
            //           center: Image.asset(imageUrl, width: 30, height: 30),
            //           progressColor: color,
            //           backgroundColor: Colors.black12,
            //         ),
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         Obx(
            //           () => Text(
            //             controller.text.value,
            //             style: const TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 18),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
              ),
              controller: controller.valueController,
              onChanged: (String text) => controller.text.value = text,
            ),
            const Spacer(),
            Row(
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
                    onPressed: () =>
                        onSave(int.parse(controller.valueController.text)),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
