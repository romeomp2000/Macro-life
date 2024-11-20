import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/impuestos/lista/impuestos_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImpuestosNuevoController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final ImpuestosListaController impuestosListaController = Get.find();

  RxBool loading = false.obs;
  RxList<SelectedModel> tiposImpuestos = [
    SelectedModel(
      text: 'Trasladado',
      value: 'Trasladado',
    ),
    SelectedModel(
      text: 'Retenido',
      value: 'Retenido',
    ),
  ].obs;

  Rx<SelectedModel?> tipoImpuestoSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> impuestos = <SelectedModel>[].obs;
  Rx<SelectedModel?> impuestoSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> tiposFactor = <SelectedModel>[].obs;
  Rx<SelectedModel?> tipoFactorSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> tasaOCuota = <SelectedModel>[].obs;
  Rx<SelectedModel?> tasaOCuotaSelected = Rx<SelectedModel?>(null);

  final loginFormKey = GlobalKey<FormState>();

  TextEditingController nombreImpuestoController = TextEditingController();

  RxBool tasaCuota = true.obs;
  RxBool cuotaIeps = false.obs;
  TextEditingController cuotaIepsController = TextEditingController();
  RxBool cuotaIva = false.obs;
  TextEditingController cuotaIvaController = TextEditingController();
  RxBool cuotaIsr = false.obs;
  TextEditingController cuotaIsrController = TextEditingController();
  RxBool sinCuota = false.obs;

  Future guardarImpuestos() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'impuestos/registrar',
          method: Method.POST,
          body: {
            'tipo_impuesto': tipoImpuestoSelected.value?.value ?? '',
            'nombre_impuesto': nombreImpuestoController.text,
            'impuesto': impuestoSelected.value?.value ?? '',
            'tipo_factor': tipoFactorSelected.value?.value ?? '',
            'tasa_cuota': tasaOCuotaSelected.value?.value ?? '',
            'tasa_cuota1': cuotaIepsController.text,
            'tasa_cuota2': cuotaIvaController.text,
            'tasa_cuota3': cuotaIsrController.text,
            'id_usuario': usuarioController.usuario.value.idUsuario,
          },
        );

        String mensaje = response['message'] ?? 'Impuesto registrado';

        Get.back();
        Get.snackbar(
          'Impuestos',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        impuestosListaController.pagingController.refresh();
      } catch (e) {
        Get.snackbar(
          'Impuestos',
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

  String? validateNombreImpuesto(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un nombre.';
    }
    return null;
  }

  Future tiposImpuestosChangue(SelectedModel? value) async {
    try {
      if (value == null || value.value!.isEmpty) {
        return;
      }

      loading.value = true;

      tipoImpuestoSelected.value = value;

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'impuestos/opciones',
        method: Method.POST,
        body: {'tipoImpuesto': value.value, 'a': 1},
      );

      final impuestosResponse = response['impuestos'] ?? [];
      final factorResponse = response['factor'] ?? [];
      final tasaOCuotaResponse = response['tasas'] ?? [];

      impuestos.clear();
      tiposFactor.clear();
      tasaOCuota.clear();

      impuestos.addAll(
        impuestosResponse
            .map<SelectedModel>(
              (e) => SelectedModel(text: e['text'], value: e['value']),
            )
            .toList(),
      );

      tiposFactor.addAll(
        factorResponse
            .map<SelectedModel>(
              (e) => SelectedModel(text: e['text'], value: e['value']),
            )
            .toList(),
      );

      tasaOCuota.addAll(
        tasaOCuotaResponse
            .map<SelectedModel>(
                (e) => SelectedModel(text: e['text'], value: e['value']))
            .toList(),
      );

      if (value.text == 'Retenido') {
        cuotaIeps.value = false;
        tasaCuota.value = false;
        cuotaIva.value = true;
      }

      // seleccionar el primero por defecto

      if (impuestos.isNotEmpty) {
        impuestoSelected.value = impuestos.first;
      } else {
        impuestoSelected.value = null;
      }

      if (tiposFactor.isNotEmpty) {
        tipoFactorSelected.value = tiposFactor.first;
      } else {
        tipoFactorSelected.value = null;
      }

      if (tasaOCuota.isNotEmpty) {
        tasaOCuotaSelected.value = tasaOCuota.first;
      } else {
        tasaOCuotaSelected.value = null;
      }
      refresh();
    } catch (e) {
      Get.snackbar(
        'Impuestos',
        'Error al cargar impuestos',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
    }
  }

  Future impuestosChangue(SelectedModel? value) async {
    try {
      if (value == null || value.value!.isEmpty) {
        return;
      }

      loading.value = true;
      impuestoSelected.value = value;

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'impuestos/opciones',
        method: Method.POST,
        body: {
          'tipoImpuesto': tipoImpuestoSelected.value!.value,
          'a': 2,
          'impuesto': value.value,
        },
      );

      final tasaOCuotaResponse = response['tasas'] ?? [];

      tasaOCuota.clear();

      tasaOCuota.addAll(
        tasaOCuotaResponse
            .map<SelectedModel>(
                (e) => SelectedModel(text: e['text'], value: e['value']))
            .toList(),
      );

      if (tipoImpuestoSelected.value?.value == 'Retenido') {
        if (impuestoSelected.value?.value == 'IVA') {
          cuotaIeps.value = false;
          tasaCuota.value = false;
          cuotaIva.value = true;
          cuotaIsr.value = false;
          sinCuota.value = false;
        }
        if (impuestoSelected.value?.value == 'IEPS') {
          cuotaIeps.value = false;
          tasaCuota.value = true;
          cuotaIva.value = false;
          cuotaIsr.value = false;
          sinCuota.value = false;
        }
        if (impuestoSelected.value?.value == 'ISR') {
          cuotaIeps.value = false;
          tasaCuota.value = false;
          cuotaIva.value = false;
          cuotaIsr.value = true;
          sinCuota.value = false;
        }
      }

      if (tiposFactor.isNotEmpty) {
        tipoFactorSelected.value = tiposFactor.first;
      } else {
        tipoFactorSelected.value = null;
      }

      if (tasaOCuota.isNotEmpty) {
        tasaOCuotaSelected.value = tasaOCuota.first;
      } else {
        tasaOCuotaSelected.value = null;
      }

      refresh();
    } catch (e) {
      Get.snackbar(
        'Impuestos',
        'Error al cargar impuestos',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
    }
  }

  void tipoFactosChangue(SelectedModel? value) {
    if (value == null || value.value!.isEmpty) {
      return;
    }

    tipoFactorSelected.value = value;

    if (tipoImpuestoSelected.value?.value == 'Trasladado') {
      if (tipoFactorSelected.value?.value == 'Cuota' &&
          impuestoSelected.value?.value == 'IVA') {
        cuotaIeps.value = false;
        tasaCuota.value = false;
        cuotaIva.value = false;
        cuotaIsr.value = false;
        sinCuota.value = true;
      }
      if (tipoFactorSelected.value?.value == 'Cuota' &&
          impuestoSelected.value?.value == 'IEPS') {
        cuotaIeps.value = true;
        tasaCuota.value = false;
        cuotaIva.value = false;
        cuotaIsr.value = false;
        sinCuota.value = false;
      }

      if (tipoFactorSelected.value?.value == 'Tasa') {
        cuotaIeps.value = false;
        tasaCuota.value = true;
        cuotaIva.value = false;
        cuotaIsr.value = false;
        sinCuota.value = false;
      }

      if (tipoFactorSelected.value?.value == 'Exento') {
        cuotaIeps.value = false;
        tasaCuota.value = false;
        cuotaIva.value = false;
        cuotaIsr.value = false;
        sinCuota.value = false;
      }
    } else {
      // retenidos
      if (tipoFactorSelected.value?.value == 'Cuota') {
        if (impuestoSelected.value?.value == 'IVA' ||
            impuestoSelected.value?.value == 'ISR') {
          cuotaIeps.value = false;
          tasaCuota.value = false;
          cuotaIva.value = false;
          cuotaIsr.value = false;
          sinCuota.value = true;
        } else {
          // ips
          cuotaIeps.value = true;
          tasaCuota.value = false;
          cuotaIva.value = false;
          cuotaIsr.value = false;
          sinCuota.value = false;
        }
      } else {
        // es tasa

        if (impuestoSelected.value?.value == 'IVA') {
          cuotaIeps.value = false;
          tasaCuota.value = false;
          cuotaIva.value = true;
          cuotaIsr.value = false;
          sinCuota.value = false;
        }
        if (impuestoSelected.value?.value == 'ISR') {
          cuotaIeps.value = false;
          tasaCuota.value = false;
          cuotaIva.value = false;
          cuotaIsr.value = true;
          sinCuota.value = false;
        }
        if (impuestoSelected.value?.value == 'IEPS') {
          cuotaIeps.value = false;
          tasaCuota.value = true;
          cuotaIva.value = false;
          cuotaIsr.value = false;
          sinCuota.value = false;
        }
      }
    }

    // seleccionar el primero por defecto
    if (tasaOCuota.isNotEmpty) {
      tasaOCuotaSelected.value = tasaOCuota.first;
    } else {
      tasaOCuotaSelected.value = null;
    }

    refresh();
  }
}
