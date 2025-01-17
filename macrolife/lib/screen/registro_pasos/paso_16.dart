import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';

Widget paso_16(RegistroPasosController controller) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        Text(
          'Crear una cuenta',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              if (GetPlatform.isIOS)
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(48, 45, 64, 1),
                        Color.fromRGBO(1, 1, 1, 1),
                      ],
                    ),
                  ),
                  child: TextButton(
                      onPressed: controller.signWithApple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Icon(
                              FontAwesomeIcons.apple,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Iniciar sesión con Apple',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      )),
                ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(48, 45, 64, 1),
                      Color.fromRGBO(1, 1, 1, 1),
                    ],
                  ),
                ),
                child: TextButton(
                    onPressed: controller.signWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Iniciar sesión con Google',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
