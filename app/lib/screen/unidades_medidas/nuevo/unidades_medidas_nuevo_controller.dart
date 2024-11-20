import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/unidades_medidas/lista/unidades_medidas_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnidadesMedidasNuevoController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final UnidadesMedidasListaController impuestosListaController = Get.find();

  RxBool loading = false.obs;

  final formFormKey = GlobalKey<FormState>();

  TextEditingController unidadController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController cveUnidadSatController = TextEditingController();

  Future guardarImpuestos() async {
    if (formFormKey.currentState!.validate()) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'unidades_medidas/registrar',
          method: Method.POST,
          body: {
            'unidad': unidadController.text,
            'descripcion': descripcionController.text,
            'unidad_sat': cveUnidadSatController.text,
            'id_usuario': usuarioController.usuario.value.idUsuario,
          },
        );

        String mensaje = response['message'] ?? 'Impuesto registrado';

        Get.back();
        Get.snackbar(
          'Unidades de Medida',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        impuestosListaController.pagingController.refresh();
      } catch (e) {
        Get.snackbar(
          'Unidades de Medida',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  String? validateDrop(SelectedModel? value) {
    if (value == null) {
      return 'Seleccione una opción.';
    }

    return null;
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido.';
    }
    return null;
  }
}
