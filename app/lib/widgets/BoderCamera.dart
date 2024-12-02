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
    return Center(
      child: SizedBox(
        width: width, // Ajusta el tamaño según necesites
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
                color: Colors.white, // Fondo transparente
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
    );
  }
}
