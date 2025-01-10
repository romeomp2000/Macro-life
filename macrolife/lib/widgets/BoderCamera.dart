import 'package:flutter/material.dart';

class BorderCamera extends StatelessWidget {
  final double width;
  final double height;

  const BorderCamera({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo oscuro con agujero transparente
        // CustomPaint(
        //   size: MediaQuery.of(context).size,
        //   painter: TransparentHolePainter(
        //     holeWidth: width,
        //     holeHeight: height,
        //   ),
        // ),

        // Esquinas del recuadro
        Center(
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                // Esquinas superiores
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 4,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 4,
                    height: 30,
                    color: Colors.white,
                  ),
                ),

                // Esquinas inferiores
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 4,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 4,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TransparentHolePainter extends CustomPainter {
  final double holeWidth;
  final double holeHeight;

  TransparentHolePainter({
    required this.holeWidth,
    required this.holeHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fondo oscuro
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Dibuja el fondo oscuro
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // // Crear agujero transparente
    final transparentPaint = Paint()..color = Colors.transparent;

    final holeX = (size.width - holeWidth) / 2;
    final holeY = (size.height - holeHeight) / 2;

    canvas.drawRect(
      Rect.fromLTWH(holeX, holeY, holeWidth, holeHeight),
      transparentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
