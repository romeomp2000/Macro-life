import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/usuario.dart';

class LayoutHomeController extends GetxController {
  UsuarioController usuarioController = Get.put(UsuarioController());

  Rx<Usuario> usuario = Usuario().obs;
  TextEditingController nombreController = TextEditingController();

  /// quiere decir que ya esta inicializado

  @override
  void onInit() {
    usuario = usuarioController.usuario;

    super.onInit();
  }

  @override
  void onReady() {
    //aca todo lo que se ejecuta cuando el controlador esta listo
    super.onReady();
  }

  @override
  void onClose() {
    //aca todo lo que se ejecuta cuando el controlador se elimina
    super.onClose();
  }
}
