import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

class TimerPickerController extends GetxController {
  Rx<TimeOfDay> horaFinal = TimeOfDay(hour: 0, minute: 0).obs;
  List<int> horas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List<int> minutos = [00, 15, 30, 45];
  List<String> horarios = ['AM', 'PM'];

  RxString horario = 'AM'.obs;
  RxInt minuto = 0.obs;

  FixedExtentScrollController scrollHora =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController scrollMinuto =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController scrollHorario =
      FixedExtentScrollController(initialItem: 0);

  int formatHora(TimeOfDay tod) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return int.parse(DateFormat('h').format(dateTime));
  }

  TimeOfDay guardar() {
    return horaFinal.value;
  }

  void onChagueHorario(
    TimeOfDay initialValue, {
    required String title,
    required Function(TimeOfDay)
        onSave, // Callback para enviar la hora seleccionada
  }) {
    horaFinal.value = initialValue;
    minuto.value = initialValue.minute;

    if (horaFinal.value.hour > 12) {
      horario.value = 'PM';
    } else {
      horario.value = 'AM';
    }

    int horaFormat = (formatHora(initialValue)) - 1;
    scrollHora = FixedExtentScrollController(initialItem: horaFormat);

    int minutoFormat = 0;
    if (initialValue.minute == 15) {
      minutoFormat = 1;
    } else if (initialValue.minute == 30) {
      minutoFormat = 2;
    } else if (initialValue.minute == 45) {
      minutoFormat = 3;
    }
    scrollMinuto = FixedExtentScrollController(initialItem: minutoFormat);

    int horarioFormat = horario.value == 'AM' ? 0 : 1;
    scrollHorario = FixedExtentScrollController(initialItem: horarioFormat);

    // Mostrar el BottomSheet
    Get.bottomSheet(
      isDismissible: true,
      enableDrag: true,
      persistent: true,
      isScrollControlled: true,
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  height: 150,
                  width: 80,
                  child: CupertinoPicker(
                    itemExtent: 35.0,
                    scrollController: scrollHora,
                    onSelectedItemChanged: onChangueHora,
                    children: horas.map((hora) {
                      return Center(child: Text('$hora'));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 80,
                  child: CupertinoPicker(
                    itemExtent: 35.0,
                    scrollController: scrollMinuto,
                    onSelectedItemChanged: (int index) {
                      onChagueMinuto(index);
                    },
                    children: minutos.map((hora) {
                      return Center(child: Text('$hora'));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 80,
                  child: CupertinoPicker(
                    itemExtent: 35.0,
                    scrollController: scrollHorario,
                    onSelectedItemChanged: onChangueHorario,
                    children: horarios.map((horario) {
                      return Center(child: Text(horario));
                    }).toList(),
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              message: 'Guardar',
              function: () {
                onSave(
                    horaFinal.value); // Enviar la hora seleccionada al callback
                Get.back(); // Cerrar el BottomSheet
              },
            ),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void onChangueHorario(int index) {
    final int currentHour = horaFinal.value.hour;
    final int baseHour = currentHour % 12; // Convertir a formato de 12 horas

    if (index == 0) {
      // Cambiar a AM
      horaFinal.value = TimeOfDay(
        hour: baseHour == 12 ? 0 : baseHour,
        minute: horaFinal.value.minute,
      );
    } else {
      // Cambiar a PM
      horaFinal.value = TimeOfDay(
        hour: baseHour == 12 ? 12 : baseHour + 12,
        minute: horaFinal.value.minute,
      );
    }

    horario.value = index == 0 ? 'AM' : 'PM';
  }

  void onChangueHora(int index) {
    final int baseHour = horario.value == 'PM' ? 12 : 0;
    int newHour = horas[index];

    if (horario.value == 'AM' && newHour == 12) {
      // Caso especial: 12 AM es 0 horas
      newHour = 0;
    } else if (horario.value == 'PM' && newHour != 12) {
      // Caso especial: 12 PM ya es 12, no sumar baseHour
      newHour += baseHour;
    }

    horaFinal.value = TimeOfDay(
      hour: newHour,
      minute: minuto.value,
    );
  }

  void onChagueMinuto(int index) {
    final List<int> minuteOptions = [0, 15, 30, 45];
    minuto.value = minuteOptions[index];
    horaFinal.value = TimeOfDay(
      hour: horaFinal.value.hour,
      minute: minuto.value,
    );
  }
}
