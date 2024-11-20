import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/usuario.dart';

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
      final data = box.read('usuario');
      if (data != null) {
        usuarioController.usuario.value = Usuario.fromJson(data);

        // Delay navigation to ensure it happens after the build cycle
        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/layout_home');
        });
      } else {
        // Delay navigation to ensure it happens after the build cycle
        Future.delayed(Duration.zero, () {
          Get.offNamed('/login');
        });
      }
    } catch (e) {
      // Delay navigation to ensure it happens after the build cycle
      Future.delayed(Duration.zero, () {
        Get.offAllNamed('/login');
      });
    }
  }
}
