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

  asegurarUsuario() {
    try {
      Get.offNamed('/layout');
      return;
      final data = box.read('usuario');
      if (data == null) {
        usuarioController.usuario.value = Usuario.fromJson(data);

        // Delay navigation to ensure it happens after the build cycle
        Get.offAllNamed('/registro');
      } else {
        // Delay navigation to ensure it happens after the build cycle
        Get.offNamed('/layout');
      }
    } catch (e) {
      // Delay navigation to ensure it happens after the build cycle
      Get.offAllNamed('/login');
    }
  }
}
