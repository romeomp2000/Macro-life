import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fep/models/usuario.dart';

class UsuarioController extends GetxController {
  Rx<Usuario> usuario = Usuario().obs;
  RxString token = ''.obs;

  /// va escuchar cambios

  final box = GetStorage();

  @override
  void onInit() {
    getUsuarioStorage();
    //aca todo lo que se ejecuta al iniciar el controlador
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

  void getUsuarioStorage() {
    final data = box.read('usuario');
    if (data != null) {
      usuario.value = Usuario.fromJson(data);
    }
  }

  // cerrar sesion
  void logout() {
    box.remove('usuario');
    box.remove('contadores');
    box.remove('modulos');
    usuario.value = Usuario();
    Get.offAllNamed('/login');
  }
}
