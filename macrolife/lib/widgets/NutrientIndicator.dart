import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
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
      height: 156,
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
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
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: blackTheme_),
              ),
              Text(
                amount > 0 ? '$nutrient\nrestante' : '$nutrient más',
                style: const TextStyle(
                  fontSize: 10,
                  color: blackThemeText,
                ),
              ),
            ],
          ),
          Center(
            child: Stack(
              children: [
                CircularPercentIndicator(
                  radius: 32.0,
                  lineWidth: 6.0,
                  percent: percent,
                  animation: true,
                  center: Image.asset(
                    icon,
                    width: 17,
                    height: 17,
                    color: color,
                  ),
                  progressColor: color,
                  backgroundColor: greyTheme_,
                  widgetIndicator: percent == 0
                      ? SizedBox()
                      : Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: color,
                              ),
                            ),
                          ),
                        ),
                ),
                percent == 0
                    ? const SizedBox()
                    : CircularPercentIndicator(
                        radius: 32.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: 0,
                        progressColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        widgetIndicator: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: color,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
