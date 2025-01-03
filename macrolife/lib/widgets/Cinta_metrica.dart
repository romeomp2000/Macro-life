import 'package:flutter/material.dart';
import 'package:macrolife/config/theme.dart';

class CintaMetrica extends StatefulWidget {
  final double min;
  final double max;
  final double step;
  final double? start;
  final double value;
  final void Function(double value) onChanged;
  const CintaMetrica(
      {super.key,
      required this.min,
      required this.max,
      required this.step,
      required this.value,
      this.start,
      required this.onChanged});

  @override
  State<CintaMetrica> createState() => _CintaMetricaState();
}

class _CintaMetricaState extends State<CintaMetrica> {
  double value = 0.0;
  int dragCounter = 0;

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
        painter: TapePainter(
            widget.min, widget.max, widget.step, value, widget.start),
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
  double? start;

  TapePainter(this.min, this.max, this.step, this.value, this.start);

  final Paint indicatorPaint = Paint()
    ..color = Colors.black54 // Customize marker color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  final Paint shadedPaint = Paint()
    ..color = Colors.blue.withOpacity(0.3)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final bgRect = Offset.zero & size;
    final innerRect = bgRect.deflate(5);

    canvas.clipRect(innerRect);
    drawMarkers(canvas, innerRect);
    drawIndicator(canvas, innerRect);
    // drawShadedArea(canvas, innerRect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawShadedArea(Canvas canvas, Rect innerRect) {
    if (start == null) return;

    double range = max - min; // Rango total de valores
    double stepSize = innerRect.width / range; // Tamaño de cada paso

    // Posición del marcador principal (indicador actual)
    double indicatorPosition = innerRect.center.dx;

    // Posición de 'start' en píxeles
    double startPosition = innerRect.center.dx - (value - start!) * stepSize;

    // Determinar los límites del sombreado
    double left =
        startPosition < indicatorPosition ? startPosition : indicatorPosition;
    double right =
        startPosition > indicatorPosition ? startPosition : indicatorPosition;

    // Asegúrate de que las coordenadas estén dentro del área visible
    left = left.clamp(innerRect.left, innerRect.right);
    right = right.clamp(innerRect.left, innerRect.right);

    // Crear y dibujar el rectángulo sombreado
    Rect shadedRect =
        Rect.fromLTRB(left, innerRect.top, right, innerRect.bottom);
    canvas.drawRect(shadedRect, shadedPaint);
  }

  void drawMarkers(Canvas canvas, Rect innerRect) {
    double range = max - min;
    double smallHeight = 10; // Altura de las marcas pequeñas
    double mediumHeight = 15; // Altura de las marcas medianas
    double largeHeight = 20; // Altura de las marcas grandes
    double markStart = 55; // Altura de las marcas grandes

    double stepSize = (innerRect.width / (range / step)) * 8;
    double offsetToIndicator = innerRect.width / 2 - (value - min) * stepSize;

    for (double i = min; i <= max; i += step) {
      double x = innerRect.left + (i - min) * stepSize + offsetToIndicator;
      const double epsilon = 0.5; // Define un margen de error pequeño
      double startPosition =
          innerRect.left + (start! - min) * stepSize + offsetToIndicator;

      // Si está cerca de la posición de inicio, dibujamos una línea con un texto
      if ((x - startPosition).abs() < epsilon) {
        // Dibuja la línea
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + markStart),
          Paint()
            ..color = blackTheme2_
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );

        // Dibuja el texto "Peso Actual"
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: "Peso Actual",
            style: TextStyle(
              color: blackTheme2_,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        // Posicionamos el texto justo debajo del marcador
        double textX = x - textPainter.width / 2;
        double textY =
            innerRect.top + markStart + 5; // Espacio extra debajo del marcador

        // Dibuja el texto en el canvas
        textPainter.paint(canvas, Offset(textX, textY));
      }

      // Dibuja las marcas grandes, medianas y pequeñas
      if (i % 10 == 0) {
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + largeHeight),
          indicatorPaint,
        );
      } else if (i % 5 == 0) {
        canvas.drawLine(
          Offset(x, innerRect.top),
          Offset(x, innerRect.top + mediumHeight),
          indicatorPaint,
        );
      } else {
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
