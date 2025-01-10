import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CustomSlider(),
        ),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _sliderValue = 0.0; // Empieza desde abajo (mínimo)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Weight Gain",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              // Fondo de la línea vertical completa
              Container(
                height: 300,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300, // Fondo de la línea
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Línea dinámica que "rodea" el ícono
              Positioned(
                bottom: 0, // Empieza desde la parte inferior
                top: (1 - _sliderValue) * 280, // Altura dinámica según el valor
                child: Container(
                  width: 4, // Ancho de la línea
                  decoration: BoxDecoration(
                    color: Colors.orange, // Color de la línea dinámica
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Slider para movimiento vertical
              SizedBox(
                height: 300,
                child: RotatedBox(
                  quarterTurns: 3, // Rotar el slider para hacerlo vertical
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 0, // Ocultar el track (línea del slider)
                      thumbShape: CustomThumbIcon(), // Ícono personalizado
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20,
                      ),
                      activeTrackColor: Colors.transparent, // Sin progreso
                      inactiveTrackColor: Colors.transparent, // Sin progreso
                    ),
                    child: Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              // Texto dinámico para mostrar el valor
              Positioned(
                top: 20,
                child: Text(
                  "${(_sliderValue * 10).toStringAsFixed(1)} kgs",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Personalización del "thumb" para usar un ícono
class CustomThumbIcon extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(50, 50); // Tamaño del ícono
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Dibuja el ícono en lugar de la bolita
    const IconData icon = Icons.circle;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 30,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.orange, // Cambia el color del ícono aquí
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2),
    );
  }
}
