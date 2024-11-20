import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fep/config/index.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/usuario.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController(text: 'PSD061106799');
  final TextEditingController passwordController =
      TextEditingController(text: '12345678');
  final RxBool obscureText = true.obs;
  final box = GetStorage();

  UsuarioController usuarioController = Get.put(UsuarioController());

  Rx<Usuario> usuario = Usuario().obs;

  @override
  void onInit() {
    usuario = usuarioController.usuario;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    obscureText.close();
    super.onClose();
  }

  Future login() async {
    return Get.offNamed('/layout');

    if (loginFormKey.currentState!.validate()) {
      try {
        var response = await http.post(
          Uri.parse('$API_URL/login'),
          body: {
            'usuario': emailController.text,
            'password': passwordController.text,
          },
        );

        String bodySt = response.body;

        var body = json.decode(bodySt);

        String message = body['message'] ?? '';

        if (response.statusCode == 200) {
          usuario.value = Usuario.fromJson(body['user']);
          box.write('usuario', usuario.value.toJson());
          Get.offAllNamed('/layout_home');
        } else {
          Get.snackbar(
            'Iniciar sesión',
            message,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Iniciar sesión',
          'Error al iniciar sesión',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      } finally {}
    }
  }

  String? validatorUsuario(String? value) {
    if (value == null || value.isEmpty) {
      return 'El usuario es requerido';
    }
    return null;
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    return null;
  }

  void changeObscureText() {
    obscureText.value = !obscureText.value;
  }

  void sendToRecoveyPassword() {
    Get.toNamed('/recovery_password');
  }

  void sendToRegister() {
    Get.toNamed('/registro');
  }
}
