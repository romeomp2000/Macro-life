import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class PrincipalController extends GetxController {
  UsuarioController usuarioController = Get.put(UsuarioController());
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    asegurarUsuario();
  }

  void asegurarUsuario() async {
    try {
      if (usuarioController.usuario.value.sId == null) {
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed('/registro');
      } else {
        await usuarioController.buscarUsuarioEntrada();
        await Future.delayed(const Duration(milliseconds: 100));
        if (usuarioController.usuario.value.fechaVencimiento == null) {
          Get.offNamed('/pago');
        } else {
          Get.offNamed('/layout');
        }
      }
    } catch (e) {
      Get.offNamed('/registro');
    }
  }
}
