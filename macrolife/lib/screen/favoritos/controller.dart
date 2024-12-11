import 'package:macrolife/config/api_service.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/home/controller.dart';

class FavoritosController extends GetxController {
  final UsuarioController controllerUsuario = Get.find();
  RxList<AlimentoModel> alimentosList = <AlimentoModel>[].obs;
  final WeeklyCalendarController controllerCalendario = Get.find();

  @override
  void onInit() async {
    super.onInit();
    obtenerFavoritos();
  }

  void obtenerFavoritos() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'favoritos',
        method: Method.POST,
        body: {"idUsuario": controllerUsuario.usuario.value.sId},
      );

      final List<AlimentoModel> alimentos =
          AlimentoModel.listFromJson(response['alimentos']);

      alimentosList.value = alimentos;

      alimentosList.refresh();
    } catch (e) {
      print(e);
    }
  }

  void favoritoHaciaComida(AlimentoModel alimento) async {
    try {
      controllerCalendario.alimentosList.insert(0, alimento);
      alimentosList.refresh();

      final apiService = ApiService();

      String fechaInsert =
          controllerCalendario.today.value.toUtc().toIso8601String();
      final response = await apiService.fetchData(
        'favoritos/favorito-alimento',
        method: Method.POST,
        body: {"idAlimento": alimento.id, "fecha": fechaInsert},
      );

      print(response);
      Get.back();

      controllerCalendario.cargaAlimentos();
    } catch (e) {
      print(e);
    }
  }
}
