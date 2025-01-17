import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/TimerPicker.dart';

Widget paso_13(RegistroPasosController controller) {
  final TimerPickerController timePic = Get.put(TimerPickerController());
  return SizedBox(
    child: Steep(
      enablePadding: true,
      isActivo: true.obs,
      enableScroll: true,
      title: '¿Qué horario te conviene?',
      options: [
        ListTileModel(
          check: false,
          title: 'Desayuno',
          subtitle: 'Define la hora de tu desayuno',
          trailing: Row(
            spacing: 10,
            children: [
              Text(
                controller.formatTimeOfDay(controller.desayuno.value),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        ListTileModel(
          check: false,
          title: 'Comida',
          subtitle: 'Define la hora de tu comida',
          trailing: Row(
            spacing: 10,
            children: [
              Text(
                controller.formatTimeOfDay(controller.comida.value),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        ListTileModel(
          check: false,
          title: 'Cena',
          subtitle: 'Define la hora de tu cena',
          trailing: Row(
            spacing: 10,
            children: [
              Text(
                controller.formatTimeOfDay(controller.cena.value),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ],
      onOptionSelected: (value) {
        if (value == 'Desayuno') {
          timePic.onChagueHorario(
            controller.desayuno.value,
            title: 'Desayuno',
            onSave: (TimeOfDay horaSeleccionada) {
              controller.desayuno.value = horaSeleccionada;
            },
          );
        }

        if (value == 'Comida') {
          timePic.onChagueHorario(
            controller.comida.value,
            title: 'Comida',
            onSave: (TimeOfDay horaSeleccionada) {
              controller.comida.value = horaSeleccionada;
            },
          );
        }

        if (value == 'Cena') {
          timePic.onChagueHorario(
            controller.cena.value,
            title: 'Cena',
            onSave: (TimeOfDay horaSeleccionada) {
              controller.cena.value = horaSeleccionada;
            },
          );
        }
      },
      selectedOption: controller.codigoController.value.text,
      onNext: controller.nextStep,
    ),
  );
}
