import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ModulosController extends GetxController {
  final UsuarioController usuarioController = Get.put(UsuarioController());

  RxList<MenuModel> modulos = <MenuModel>[].obs;

  @override
  void onInit() {
    obtenerModulosStorage();
    super.onInit();
  }

  Future obtenerModulosStorage() async {
    obtenerModulos();
    final box = GetStorage();
    final data = box.read('modulos');
    if (data != null) {
      modulos.value = (data as List).map((e) => MenuModel.fromJson(e)).toList();
    }
  }

  Future obtenerModulos() async {
    try {
      final apiService = ApiService();
      int? idUsuario = usuarioController.usuario.value.idUsuario;
      final response = await apiService.fetchData('modulos/${idUsuario ?? 0}');

      modulos.value = response['modulos']
          .map<MenuModel>((e) => MenuModel.fromJson(e))
          .toList();

      final box = GetStorage();
      box.write('modulos', modulos);
    } catch (e) {
      Get.snackbar(
        'Modulos',
        'Error al obtener modulos',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
