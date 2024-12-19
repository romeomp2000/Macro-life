import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/usuario.dart';

class UsuarioController extends GetxController {
  Rx<Usuario> usuario = Usuario().obs;
  Rx<MacronutrientesCalculo> macronutrientes = MacronutrientesCalculo().obs;

  RxString token = ''.obs;

  /// va escuchar cambios

  final box = GetStorage();

  @override
  void onInit() {
    getUsuarioStorage();
    getMacronutrientesStorage();
    buscarUsuario();
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

  void getMacronutrientesStorage() {
    final data = box.read('macronutrientes');
    if (data != null) {
      macronutrientes.value = MacronutrientesCalculo.fromJson(data);
    }
  }

  // cerrar sesion
  void logout() {
    box.remove('usuario');
    box.remove('macronutrientes');
    usuario.value = Usuario();
    macronutrientes.value = MacronutrientesCalculo();

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

  void saveMacronutrientesStorage(MacronutrientesCalculo macronutrientesJson) {
    // Guardar el objeto 'usuario' en el almacenamiento
    box.write('macronutrientes', macronutrientesJson.toJson());
    macronutrientes.value = macronutrientesJson;
  }

  void saveMacronutrientesFromJson(Map<String, dynamic> json) {
    // Guardar el JSON directamente en el almacenamiento
    try {
      box.write('macronutrientes', json);

      macronutrientes.value = MacronutrientesCalculo.fromJson(json);

      macronutrientes.refresh();
    } on Exception catch (e) {
      print(e);
    }
  }

  void buscarUsuario() async {
    try {
      if (usuario.value.sId != null && usuario.value.sId != '') {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'usuario/buscar/${usuario.value.sId}',
          method: Method.GET,
          body: {},
        );

        saveUsuarioFromJson(response['usuario']);
        // if (response['usuario']['estatus'] == 'Activo') {
        //   Get.offAndToNamed('/registro_pasos');
        // }

        print(response);
      }
    } catch (e) {
      print(e);
    }
  }
}
