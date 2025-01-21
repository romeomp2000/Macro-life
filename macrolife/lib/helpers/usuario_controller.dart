import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:live_activities/live_activities.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/usuario.dart';
import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';
import 'package:macrolife/screen/home/controller.dart';

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
  void logout() async {
    Get.back(); // Cerrar el cuadro de diálogo
    Get.offAndToNamed('/registro'); // Realizar la acción

    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/eliminar-cuenta',
      method: Method.POST,
      body: {
        "idUsuario": usuario.value.sId,
      },
    );

    box.remove('usuario');
    box.remove('macronutrientes');
    box.remove('liveActivitiesEnable');
    box.remove('macronutrientes');

    final liveActivities = Get.put(LiveActivitiesController());

    liveActivities.eliminar();
    usuario.value = Usuario();
    macronutrientes.value = MacronutrientesCalculo();
    refresh();
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
      final WeeklyCalendarController controllerCalendario =
          Get.put(WeeklyCalendarController(), permanent: true);
      int rachaAnterior = usuario.value.rachaDias ?? 0;

      box.write('usuario', json);

      usuario.value = Usuario.fromJson(json);
      int rachaNueva = usuario.value.rachaDias ?? 0;

      if (rachaAnterior != rachaNueva) {
        controllerCalendario.onRachaDias();
      }

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

  Future buscarUsuarioEntrada() async {
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
