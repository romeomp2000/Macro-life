import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/usuario.dart';

class PrincipalController extends GetxController {
  UsuarioController usuarioController = Get.put(UsuarioController());

  final box = GetStorage();

  @override
  void onInit() {
    asegurarUsuario();
    //aca todo lo que se ejecuta al iniciar el controlador
    super.onInit();
  }

  @override
  void onReady() {
    //aca todo lo que se ejecuta cuando el controlador esta listo
    super.onReady();
  }

  asegurarUsuario() async {
    try {
      if (usuarioController.usuario.value.sId == null) {
        await Future.delayed(Duration(
            milliseconds:
                100)); // Small delay to avoid quick successive navigation

        Get.offNamed('/registro');
      } else {
        await Future.delayed(Duration(
            milliseconds:
                100)); // Small delay to avoid quick successive navigation

        Get.offNamed('/layout');
      }
      return;
    } catch (e) {
      Get.offNamed('/registro');
    }
  }
}
