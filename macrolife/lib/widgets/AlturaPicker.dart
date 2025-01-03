import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlturaPesoPicker extends StatelessWidget {
  final ValueChanged<int> onAlturaSelected;
  final ValueChanged<int> onPesoSelected;

  // Agregar parámetros para los valores predeterminados reales
  final int defaultAltura;
  final int defaultPeso;

  // Constructor que recibe las funciones de callback y los valores predeterminados reales
  AlturaPesoPicker({
    super.key,
    required this.onAlturaSelected,
    required this.onPesoSelected,
    this.defaultAltura = 60, // Valor por defecto de altura
    this.defaultPeso = 20, // Valor por defecto de peso
  });

  final List<int> alturas =
      List<int>.generate(184, (i) => 60 + i); // Genera alturas de 60 a 243 cm
  final List<int> pesos =
      List<int>.generate(341, (i) => 20 + i); // Genera pesos de 20 a 360 kg

  @override
  Widget build(BuildContext context) {
    // Encuentra el índice correspondiente al valor de altura y peso predeterminados
    int defaultAlturaIndex = alturas.indexOf(defaultAltura);
    int defaultPesoIndex = pesos.indexOf(defaultPeso);

    return Center(
      child: Column(
        children: [
          const Text(
            "Métrica",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Altura",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Texto en negritas
                    ),
                    SizedBox(
                      height: 170,
                      child: CupertinoPicker(
                        itemExtent: 32.0,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                defaultAlturaIndex), // Índice correspondiente
                        onSelectedItemChanged: (int index) {
                          // Llama a la función callback con el valor seleccionado
                          onAlturaSelected(alturas[index]);
                        },
                        children: alturas.map((altura) {
                          return Center(child: Text('$altura cm'));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Peso",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Texto en negritas
                    ),
                    SizedBox(
                      height: 170,
                      child: CupertinoPicker(
                        itemExtent: 32.0,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                defaultPesoIndex), // Índice correspondiente
                        onSelectedItemChanged: (int index) {
                          // Llama a la función callback con el valor seleccionado
                          onPesoSelected(pesos[index]);
                        },
                        children: pesos.map((peso) {
                          return Center(child: Text('$peso kg'));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
