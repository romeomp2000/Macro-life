import 'package:macrolife/screen/EditarNutrientes/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EditarNutrientesScreen extends StatelessWidget {
  final Color color;
  final String imageUrl;
  final String title;
  final String textField;
  final int initialValue;
  final Function(int) onSave;

  const EditarNutrientesScreen({
    super.key,
    required this.color,
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
            const SizedBox(height: 20),
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
                    child: SfCartesianChart(
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 100,
                        interval: 50,
                        opposedPosition: true,
                        borderColor: Colors.black12,
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
                          color: color,
                          xValueMapper: (ChartData data, _) => data.label,
                          yValueMapper: (ChartData data, _) => data.value,
                        )
                      ],
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
