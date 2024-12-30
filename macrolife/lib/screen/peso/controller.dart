import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class PesoObjetivoController extends GetxController {
  final UsuarioController controllerUsuario = Get.find();

  final RxInt peso = 0.obs;

  @override
  void onInit() {
    peso.value = controllerUsuario.usuario.value.pesoActual ?? 0;
    
    //aca todo lo que se ejecuta al iniciar el controlador
    super.onInit();
  }

  void guardaPeso() async {
    controllerUsuario.usuario.value.pesoActual = peso.value;

    controllerUsuario.usuario.refresh();
    controllerUsuario.refresh();

    Get.back();

    final apiService = ApiService();

    final response = await apiService.fetchData(
      'peso/actual',
      method: Method.POST,
      body: {
        "idUsuario": controllerUsuario.usuario.value.sId,
        'pesoActual': peso.value,
      },
    );

    print(response);
  }
}
