import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      width: (Get.width * 0.3) - 5,
      height: 152,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
          width: 1.0, // Ancho del borde
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                amount > 0 ? '$nutrient\nrestante' : '$nutrient más',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
          Center(
            child: CircularPercentIndicator(
              radius: 32.0,
              lineWidth: 6.0,
              percent: percent, // Ajusta el valor de progreso
              center: Image.asset(
                icon,
                width: 17,
                height: 17,
                color: color,
              ),
              progressColor: color, // Color del progreso
              backgroundColor: Colors.black12, // Color del fondo del círculo
            ),
          )
        ],
      ),
    );
  }
}
