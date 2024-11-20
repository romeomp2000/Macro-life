import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/screen/etiquetas_personalizadas/lista/etiquetas_personalizadas_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtiquetasPersonalizadasNuevoController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final EtiquetasPersonalizadasListaController listaController = Get.find();

  RxBool loading = false.obs;

  final formFormKey = GlobalKey<FormState>();

  TextEditingController etiquetaController = TextEditingController();

  Future guardar() async {
    if (formFormKey.currentState!.validate()) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'etiquetas/registrar',
          method: Method.POST,
          body: {
            'etiqueta': etiquetaController.text,
            'id_usuario': usuarioController.usuario.value.idUsuario,
          },
        );

        String mensaje = response['message'] ?? 'Etiqueta registrada.';

        Get.back();
        Get.snackbar(
          'Etiquetas',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        listaController.pagingController.refresh();
      } catch (e) {
        Get.snackbar(
          'Etiquetas',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido.';
    }
    return null;
  }
}
