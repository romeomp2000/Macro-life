import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/etiquetas_personalizadas/lista/etiquetas_personalizadas_lista_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtiquetasPersonalizadasEditarController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final EtiquetasPersonalizadasListaController listaController = Get.find();
  final argumentos = Get.arguments;

  RxBool loading = false.obs;

  final formFormKey = GlobalKey<FormState>();

  TextEditingController etiquetaController = TextEditingController();

  Future guardar() async {
    if (formFormKey.currentState!.validate()) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'etiquetas/editar',
          method: Method.POST,
          body: {
            'id_registro': argumentos?.idEtiqueta,
            'etiqueta': etiquetaController.text,
          },
        );

        String mensaje = response['message'] ?? 'Etiqueta actualizada.';

        Get.back();
        Get.snackbar(
          'Etiquetas Personalizadas',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        listaController.pagingController.refresh();
      } catch (e) {
        Get.snackbar(
          'Etiquetas Personalizadas',
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
        etiquetaController.text = argumentos.etiqueta ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Etiquetas Personalizadas',
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
                  '¿Estás seguro de que deseas eliminar esta etiqueta personalizada?'),
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
                  '¿Estás seguro de que deseas eliminar esta etiqueta personalizada?'),
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
          'etiquetas/eliminar',
          method: Method.POST,
          body: {
            'id_registro': argumentos.idEtiqueta,
          },
        );

        String mensaje = response['message'] ?? 'Etiqueta eliminada.';

        Get.back();

        listaController.pagingController.refresh();
        Get.snackbar(
          'Etiquetas Personalizadas',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } catch (e) {
        Get.snackbar(
          'Etiquetas Personalizadas',
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
