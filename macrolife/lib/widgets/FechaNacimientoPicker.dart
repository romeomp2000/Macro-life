import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FechaNacimientoPicker extends StatefulWidget {
  final ValueChanged<DateTime> onFechaSeleccionada;

  final int defaultMes;
  final int defaultDia;
  final int defaultAnio;

  FechaNacimientoPicker({
    super.key,
    required this.onFechaSeleccionada,
    this.defaultMes = 1,
    this.defaultDia = 1,
    this.defaultAnio = 2000,
  });

  @override
  _FechaNacimientoPickerState createState() => _FechaNacimientoPickerState();
}

class _FechaNacimientoPickerState extends State<FechaNacimientoPicker> {
  late int selectedDia;
  late int selectedMes;
  late int selectedAnio;

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

  final List<int> dias = List<int>.generate(31, (i) => i + 1);
  final List<int> anios = List<int>.generate(131, (i) => 1900 + i);

  @override
  void initState() {
    super.initState();
    selectedDia = widget.defaultDia;
    selectedMes = widget.defaultMes;
    selectedAnio = widget.defaultAnio;
  }

  List<int> getDiasDelMes(int mes, int anio) {
    // Dependiendo del mes y el año, ajustamos los días disponibles
    if (mes == 2) {
      // Febrero (considerando años bisiestos)
      if ((anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0)) {
        return List.generate(29, (i) => i + 1); // 29 días en años bisiestos
      }
      return List.generate(28, (i) => i + 1); // 28 días en años no bisiestos
    } else if (mes == 4 || mes == 6 || mes == 9 || mes == 11) {
      // Meses con 30 días
      return List.generate(30, (i) => i + 1);
    }
    // Meses con 31 días
    return List.generate(31, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    int defaultMesIndex = selectedMes - 1;
    int defaultDiaIndex =
        getDiasDelMes(selectedMes, selectedAnio).indexOf(selectedDia);
    int defaultAnioIndex = anios.indexOf(selectedAnio);

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController:
                    FixedExtentScrollController(initialItem: defaultDiaIndex),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedDia =
                        getDiasDelMes(selectedMes, selectedAnio)[index];
                  });
                  widget.onFechaSeleccionada(
                      DateTime(selectedAnio, selectedMes, selectedDia));
                },
                children: getDiasDelMes(selectedMes, selectedAnio).map((dia) {
                  return Center(child: Text('$dia'));
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController:
                    FixedExtentScrollController(initialItem: defaultMesIndex),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedMes = index + 1;
                    selectedDia = getDiasDelMes(selectedMes, selectedAnio)
                            .contains(selectedDia)
                        ? selectedDia
                        : getDiasDelMes(selectedMes, selectedAnio).last;
                  });
                  widget.onFechaSeleccionada(
                      DateTime(selectedAnio, selectedMes, selectedDia));
                },
                children: meses.map((mes) {
                  return Center(child: Text(mes));
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController:
                    FixedExtentScrollController(initialItem: defaultAnioIndex),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedAnio = anios[index];
                    // Si el día seleccionado no es válido para el nuevo año y mes,
                    // lo ajustamos a un valor válido
                    selectedDia = getDiasDelMes(selectedMes, selectedAnio)
                            .contains(selectedDia)
                        ? selectedDia
                        : getDiasDelMes(selectedMes, selectedAnio).last;
                  });
                  widget.onFechaSeleccionada(
                      DateTime(selectedAnio, selectedMes, selectedDia));
                },
                children: anios.map((anio) {
                  return Center(child: Text('$anio'));
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
