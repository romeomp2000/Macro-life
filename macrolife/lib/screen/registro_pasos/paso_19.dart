import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_19(RegistroPasosController controller) {
  return SizedBox(
    child: Steep(
      isActivo: true.obs,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            spacing: 25,
            children: [
              if (GetPlatform.isIOS)
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(FontAwesomeIcons.apple),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                      iconColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: controller.signWithApple,
                    label: Text('Iniciar sesión con Apple'),
                  ),
                ),
              SizedBox(
                width: Get.width,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(FontAwesomeIcons.google),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                    iconColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: controller.signWithGoogle,
                  label: Text('Iniciar sesión con Google'),
                ),
              ),
            ],
          ),
        ),
      ),
      title: 'Crear una cuenta',
      options: const [],
      onOptionSelected: (nombre) {},
      selectedOption: controller.correoController.value.text,
      onNext: null,
    ),
  );
}
