import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/index.dart';
import 'package:http/http.dart' as http;

class RecoveryPasswordController extends GetxController {
  final correo = TextEditingController();

  final GlobalKey<FormState> formKeyRecoveryPassword = GlobalKey<FormState>();

  final RxBool loading = false.obs;
  final RxBool send = false.obs;

  @override
  void onClose() {
    correo.dispose();
    super.onClose();
  }

  Future sendRecoveryPassword() async {
    if (formKeyRecoveryPassword.currentState!.validate()) {
      loading.value = true;
      try {
        var response = await http.post(
          Uri.parse('$API_URL/auth/recovery_password'),
          body: {
            'correo': correo.text,
          },
        );

        String bodySt = response.body;

        var body = json.decode(bodySt);

        String message = body['message'] ?? '';

        if (response.statusCode == 200) {
          send.value = true;

          Get.snackbar(
            'Recuperar contraseña',
            message,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );
        } else {
          Get.snackbar(
            'Recuperar contraseña',
            message,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Error al enviar el correo'),
          ),
        );
      } finally {
        loading.value = false;
      }
      loading.value = false;
    }
  }
}
