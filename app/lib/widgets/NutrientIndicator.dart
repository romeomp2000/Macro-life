import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class NutrientIndicator extends StatelessWidget {
  final int amount;
  final String nutrient;
  final double percent;
  final Color color;
  final String icon;

  NutrientIndicator({
    required this.amount,
    required this.nutrient,
    required this.percent,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 170,
      // color: Colors.white,
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
                '$nutrient restante',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 7.0,
            percent: percent,
            center: Image.network(
              icon,
              width: 15,
            ),
            progressColor: color,
            backgroundColor: Colors.black12,
          ),
        ],
      ),
    );
  }
}
