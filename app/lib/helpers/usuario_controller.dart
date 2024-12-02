import 'package:fep/screen/analitica/controller.dart';
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
    usuario.value = Usuario();
    Get.offAllNamed('/login');
  }

  void onRefresh() {
    refresh();
  }

  void saveUsuarioStorage(Usuario usuarioJson) {
    // Guardar el objeto 'usuario' en el almacenamiento
    box.write('usuario', usuarioJson.toJson());
    usuario.value = usuarioJson;
  }

  void saveUsuarioFromJson(Map<String, dynamic> json) {
    // Guardar el JSON directamente en el almacenamiento
    try {
      box.write('usuario', json);

      usuario.value = Usuario.fromJson(json);

      usuario.refresh();
    } on Exception catch (e) {
      print(e);
    }
  }
}
