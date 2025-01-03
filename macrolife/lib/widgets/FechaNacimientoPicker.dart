import 'package:flutter/cupertino.dart';

class FechaNacimientoPicker extends StatelessWidget {
  final ValueChanged<DateTime> onFechaSeleccionada;

  // Agregar parámetros para los valores predeterminados de fecha
  final int defaultMes;
  final int defaultDia;
  final int defaultAnio;

  // Constructor que recibe las funciones de callback y los valores predeterminados reales
  FechaNacimientoPicker({
    super.key,
    required this.onFechaSeleccionada,
    this.defaultMes = 1, // Mes por defecto (Enero)
    this.defaultDia = 1, // Día por defecto (1)
    this.defaultAnio = 2000, // Año por defecto (2000)
  });

  final List<String> meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  final List<int> dias =
      List<int>.generate(31, (i) => i + 1); // Días del 1 al 31
  final List<int> anios =
      List<int>.generate(131, (i) => 1900 + i); // Años de 1900 a 2030

  @override
  Widget build(BuildContext context) {
    // Encuentra el índice correspondiente al valor de mes, día y año predeterminados
    int defaultMesIndex =
        defaultMes - 1; // Los índices empiezan desde 0, por lo que restamos 1
    int defaultDiaIndex = dias.indexOf(defaultDia);
    int defaultAnioIndex = anios.indexOf(defaultAnio);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text(
                //   "Día",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultDiaIndex), // Índice de día
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(
                          anios[defaultAnioIndex],
                          meses[defaultMesIndex] == "Enero"
                              ? 1
                              : (defaultMesIndex + 1),
                          index + 1);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: dias.map((dia) {
                      return Center(child: Text('$dia'));
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
                // const Text(
                //   "Mes",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultMesIndex), // Índice de mes
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(anios[defaultAnioIndex],
                          index + 1, dias[defaultDiaIndex]);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: meses.map((mes) {
                      return Center(child: Text(mes));
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
                // const Text(
                //   "Año",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultAnioIndex), // Índice de año
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(
                          anios[index],
                          meses[defaultMesIndex] == "Enero"
                              ? 1
                              : (defaultMesIndex + 1),
                          dias[defaultDiaIndex]);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: anios.map((anio) {
                      return Center(child: Text('$anio'));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
