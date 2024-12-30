import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class PesoObjetivoController extends GetxController {
  final UsuarioController controllerUsuario = Get.find();

  final RxInt pesoObjetivo = 0.obs;
  @override
  void onInit() {
    pesoObjetivo.value = controllerUsuario.usuario.value.pesoObjetivo ?? 0;
    //aca todo lo que se ejecuta al iniciar el controlador
    super.onInit();
  }

  void guardaObjetivoPeso() async {
    FuncionesGlobales.vibratePress();

    controllerUsuario.usuario.value.pesoObjetivo = pesoObjetivo.value;

    controllerUsuario.usuario.refresh();
    controllerUsuario.refresh();

    Get.back();

    final apiService = ApiService();

    await apiService.fetchData(
      'peso/objetivo',
      method: Method.POST,
      body: {
        "idUsuario": controllerUsuario.usuario.value.sId,
        'pesoObjetivo': pesoObjetivo.value,
      },
    );
  }
}
