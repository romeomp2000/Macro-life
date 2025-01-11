import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
                amount > 0 ? '${amount}g' : '${amount.abs()}g',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                amount > 0 ? '$nutrient\nrestante' : '$nutrient más',
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
                child:
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
                    //     ColumnSeries<ChartData, String>(
                    //       dataSource: [
                    //         ChartData('', percent, Colors.white),
                    //       ],
                    //       width: 1,
                    //       color: color,
                    //       borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(2),
                    //         topRight: Radius.circular(2),
                    //       ),
                    //       xValueMapper: (ChartData data, _) => data.label,
                    //       yValueMapper: (ChartData data, _) => data.value,
                    //     ),
                    //   ],
                    // ),
                    BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            fromY: 0,
                            toY: percent == 100.0 || percent == 0
                                ? percent
                                : (100 - percent),
                            color: Colors.black,
                            width: 25,
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
                      show: false, // Ocultar títulos de los ejes
                    ),
                    gridData: FlGridData(
                      show: false, // Ocultar líneas de la cuadrícula
                    ),
                    borderData: FlBorderData(
                      show: false, // Ocultar bordes del gráfico
                    ),
                    barTouchData: BarTouchData(
                      enabled: false, // Desactivar interacción con las barras
                    ),
                  ),
                ),
              ),
              Image.asset(
                icon,
                width: 30,
                height: 30,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
