import 'package:flutter/material.dart';

class CintaMetrica extends StatefulWidget {
  final double min;
  final double max;
  final double step;
  final double value;
  final void Function(double value) onChanged;
  const CintaMetrica(
      {super.key,
      required this.min,
      required this.max,
      required this.step,
      required this.value,
      required this.onChanged});

  @override
  State<CintaMetrica> createState() => _CintaMetricaState();
}

class _CintaMetricaState extends State<CintaMetrica> {
  double value = 0.0;
  int dragCounter =
      0; // Contador para controlar cada cuántos desplazamientos aplicar el cambio

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (val) {
        dragCounter++; // Incrementa el contador en cada desplazamiento

        // Solo aplica el cambio en cada segundo desplazamiento
        if (dragCounter % 2 == 0) {
          value = value - val.delta.dx;

          // Limita el valor dentro del rango permitido
          if (value < widget.min) {
            value = widget.min;
          }
          if (value > widget.max) {
            value = widget.max;
          }

          widget.onChanged(value);
          setState(() {});
        }
      },
      child: CustomPaint(
        painter: TapePainter(widget.min, widget.max, widget.step, value),
        child: Container(),
      ),
    );
  }
}

class TapePainter extends CustomPainter {
  double min;
  double max;
  double step;
  double value;

  TapePainter(this.min, this.max, this.step, this.value);

  // final Paint bgPainter = Paint()
  //   ..color = Colors.white
  //   ..style = PaintingStyle.fill;

  // final Paint borderPaint = Paint()
  //   ..color = Colors.black
  //   ..style = PaintingStyle.stroke
  //   ..strokeWidth = 0.0;
  final Paint indicatorPaint = Paint()
    ..color = Colors.black54 // Customize marker color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final bgRect = Offset.zero & size;

    ///main green container
    // canvas.drawRect(bgRect, bgPainter);

    ///main black  stroke rectangle

    // canvas.drawRect(bgRect, borderPaint);
    final innerRect = bgRect.deflate(5);
    // canvas.drawRect(innerRect, borderPaint);

    ///marker
    ///
// Draw custom marker at the current value
    ///for making rect inner inside
    canvas.clipRect(innerRect);
    drawMarkers(canvas, innerRect);
    // drawValue(canvas, innerRect);
    drawIndicator(canvas, innerRect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void drawMarkers(Canvas canvas, Rect innerRect) {
    double range = max - min;
    double smallHeight = 10; // Altura de las marcas pequeñas
    double mediumHeight = 15; // Altura de las marcas medianas
    double largeHeight = 20; // Altura de las marcas grandes

    // Ajusta el tamaño del paso para que los números no se vean muy juntos
    double stepSize = (innerRect.width / (range / step)) * 8;
    double offsetToIndicator = innerRect.width / 2 - (value - min) * stepSize;

    for (double i = min; i <= max; i += step) {
      double x = innerRect.left + (i - min) * stepSize + offsetToIndicator;

      // Determinamos el tamaño de la marca según el valor
      if (i % 10 == 0) {
        // Marcadores grandes con números
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + largeHeight),
          indicatorPaint,
        );
      } else if (i % 5 == 0) {
        // Marcadores medianos (múltiplos de 5)
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + mediumHeight),
          indicatorPaint,
        );
      } else {
        // Marcadores pequeños (todos los demás)
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + smallHeight),
          indicatorPaint,
        );
      }
    }
  }

  void drawIndicator(Canvas canvas, Rect innerRect) {
    final c1 = innerRect.topCenter;
    final c2 = innerRect.center;

    canvas.drawLine(c1, c2, indicatorPaint);
  }
}
