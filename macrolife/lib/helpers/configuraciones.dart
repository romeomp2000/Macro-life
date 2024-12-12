import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/configuraciones.model.dart';

class ConfiguracionesController extends GetxController {
  Rx<ConfiguracionesModel> configuraciones = ConfiguracionesModel().obs;

  final box = GetStorage();

  @override
  void onInit() {
    buscaConfiguraciones();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   //aca todo lo que se ejecuta cuando el controlador esta listo
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   //aca todo lo que se ejecuta cuando el controlador se elimina
  //   super.onClose();
  // }

  void onRefresh() {
    refresh();
  }

  Future buscaConfiguraciones() async {
    try {
      final data = box.read('configuraciones');
      if (data != null) {
        configuraciones.value = ConfiguracionesModel.fromJson(data);
      }

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'configuraciones',
        method: Method.GET,
        body: {},
      );

      configuraciones.value = ConfiguracionesModel.fromJson(response);

      box.write('configuraciones', configuraciones.toJson());

      print(response);
    } catch (e) {
      print(e);
    }
  }
}
