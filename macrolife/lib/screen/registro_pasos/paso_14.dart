import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';

Widget paso_14(RegistroPasosController controller) {
  return SizedBox(
    child: Steep(
      enablePadding: true,
      enableScroll: true,
      isActivo: true.obs,
      body: Column(
        spacing: 50,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Color.fromARGB(255, 246, 246, 246),
              ),
            ),
            child: Image.asset(
              'assets/icons/icono_usuarios_80x80_activo.png',
              width: 40,
            ),
          ),
          CustomTextFormField(
            focus: false,
            keyboardType: TextInputType.text,
            controller: controller.codigoController,
            onChanged: (p0) {
              controller.correo.value = p0;
            },
            label: 'Código de referencia',
          ),
        ],
      ),
      enabledButtonSaltar: true,
      title: '¿Tienes un código de referencia?',
      options: const [],
      selectedOption: controller.codigoController.value.text,
      onNext: controller.nextStep,
    ),
  );
}
