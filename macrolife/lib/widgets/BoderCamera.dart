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
        // Parte superior con fondo gris y opacidad
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: (MediaQuery.of(context).size.height - height) /
                2, // Espacio de la parte superior
            color: Colors.black.withOpacity(0.4), // Gris con opacidad
          ),
        ),

        // Parte inferior con fondo gris y opacidad
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: (MediaQuery.of(context).size.height - height) /
                2, // Espacio de la parte inferior
            color: Colors.black.withOpacity(0.4), // Gris con opacidad
          ),
        ),

        // Parte izquierda con fondo gris y opacidad
        Positioned(
          top: (MediaQuery.of(context).size.height - height) / 2,
          left: 0,
          child: Container(
            width: (MediaQuery.of(context).size.width - width) /
                2, // Espacio de la parte izquierda
            height: height, // Mantener la altura del centro
            color: Colors.black.withOpacity(0.4), // Gris con opacidad
          ),
        ),

        // Parte derecha con fondo gris y opacidad
        Positioned(
          top: (MediaQuery.of(context).size.height - height) / 2,
          right: 0,
          child: Container(
            width: (MediaQuery.of(context).size.width - width) /
                2, // Espacio de la parte derecha
            height: height, // Mantener la altura del centro
            color: Colors.black.withOpacity(0.4), // Gris con opacidad
          ),
        ),

        // Área central sin color gris
        Center(
          child: Container(
            width: width,
            height: height,
            color: Colors
                .transparent, // Área central transparente (sin color gris)
            child: Stack(
              children: [
                // Esquinas superiores
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 30,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 5,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 5,
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
                    height: 5,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 5,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 5,
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
