import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/unidades_medidas/lista/unidades_medidas_lista_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnidadesMedidasEditarController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final UnidadesMedidasListaController listaController = Get.find();
  final argumentos = Get.arguments;

  RxBool loading = false.obs;

  final formFormKey = GlobalKey<FormState>();

  TextEditingController unidadController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController cveUnidadSatController = TextEditingController();

  List<SelectedModel> estatus = [
    SelectedModel(value: 'activo', text: 'Activo'),
    SelectedModel(value: 'inactivo', text: 'Inactivo'),
  ];

  Rx<SelectedModel?> estatusSelected =
      SelectedModel(value: 'activo', text: 'Activo').obs;

  Future guardarImpuestos() async {
    if (formFormKey.currentState!.validate()) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'unidades_medidas/editar',
          method: Method.POST,
          body: {
            'id_registro': argumentos?.idUnidad,
            'unidad': unidadController.text,
            'descripcion': descripcionController.text,
            'unidad_sat': cveUnidadSatController.text,
            'estatus': estatusSelected.value?.value,
          },
        );

        String mensaje = response['message'] ?? 'Unidad de medida guardada.';

        Get.back();
        Get.snackbar(
          'Unidades de Medida',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        listaController.pagingController.refresh();
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

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;

    try {
      if (argumentos != null) {
        if (argumentos?.estatus != null) {
          final SelectedModel estatusSelected = estatus.firstWhere(
            (element) => element.value == argumentos?.estatus,
            orElse: () => SelectedModel(value: 'activo', text: 'Activo'),
          );

          this.estatusSelected.value = estatusSelected;
        }

        if (argumentos?.unidad != null) {
          unidadController.text = argumentos?.unidad;
        }

        if (argumentos?.descripcion != null) {
          descripcionController.text = argumentos?.descripcion;
        }

        if (argumentos?.unidadSat != null) {
          cveUnidadSatController.text = argumentos?.unidadSat;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Unidades de Medida',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
    }
  }

  Future delete() async {
    // Mostrar un diálogo de confirmación basado en la plataforma
    bool? confirm = await Get.dialog<bool>(
      GetPlatform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Confirmación'),
              content: const Text(
                  '¿Estás seguro de que deseas eliminar esta unidad de medida?'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black)),
                ),
                CupertinoDialogAction(
                  onPressed: () => Get.back(result: true),
                  isDestructiveAction: true, // Destacar el botón de eliminar
                  child: const Text('Eliminar',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Confirmación'),
              content: const Text(
                  '¿Estás seguro de que deseas eliminar esta unidad de medida?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text('Eliminar',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
    );

    // Si el usuario confirma, proceder con la eliminación
    if (confirm == true) {
      try {
        loading.value = true;
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'unidades_medidas/eliminar',
          method: Method.POST,
          body: {
            'id_registro': argumentos.idUnidad,
          },
        );

        String mensaje = response['message'] ?? 'Unidad de medida eliminada.';

        Get.back();

        listaController.pagingController.refresh();
        Get.snackbar(
          'Unidades de Medida',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } catch (e) {
        Get.snackbar(
          'Unidades de Medida',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      } finally {
        loading.value = false;
      }
    }
  }
}
