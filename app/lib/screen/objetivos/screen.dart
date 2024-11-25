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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Macronutrientes',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                      builder: (dynamic data, dynamic point, dynamic series,
                          int pointIndex, int seriesIndex) {
                        ChartData chartData = data;
                        return Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color:
                                chartData.color, // Fondo del color del segmento
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
                lineWidth: 7.0,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              subtitle: const Text(
                '1,292',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25),
            CupertinoListTile(
              leadingSize: 67,
              padding: EdgeInsets.zero,
              leading: CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 7.0,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              subtitle: const Text(
                '134',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25),
            CupertinoListTile(
              leadingSize: 67,
              padding: EdgeInsets.zero,
              leading: CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 7.0,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              subtitle: const Text(
                '108',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25),
            CupertinoListTile(
              leadingSize: 67,
              padding: EdgeInsets.zero,
              leading: CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 7.0,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              subtitle: const Text(
                '35',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Color de fondo blanco
                  foregroundColor: Colors.black, // Color del texto negro
                  side: const BorderSide(
                      color: Colors.black, width: 1.5), // Borde negro
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ), // Espaciado interno
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
    );
  }
}
