import 'package:flutter/material.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NutrientIndicator extends StatelessWidget {
  final int amount;
  final String nutrient;
  final double percent;
  final Color color;
  final String icon;

  const NutrientIndicator({
    super.key,
    required this.amount,
    required this.nutrient,
    required this.percent,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 200,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white, // Color del borde
          width: 1.0, // Ancho del borde
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${amount}g',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$nutrient\nrestante',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 38,
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
                        ChartData('', percent, Colors.white),
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
                icon,
                width: 30,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
