import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/series/lista/series_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesNuevoController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  // final SeriesListaController impuestosListaController = Get.find();
  final SeriesListaController seriesListaController = Get.find();
  final primeroFormKey = GlobalKey<FormState>();

  //? segundo
  final segundoFormKey = GlobalKey<FormState>();
  RxList<SelectedModel> estados = <SelectedModel>[].obs;
  Rx<SelectedModel?> estadoSelected = Rx<SelectedModel?>(null);
  TextEditingController nombreSocursalController = TextEditingController();
  TextEditingController calleController = TextEditingController();
  TextEditingController numeroExteriorController = TextEditingController();
  TextEditingController numeroInteriorController = TextEditingController();
  TextEditingController coloniaController = TextEditingController();
  TextEditingController municipioController = TextEditingController();
  TextEditingController codigoPostalController = TextEditingController();

  //? segundo

  RxInt currentStep = 0.obs;

  TextEditingController descripcionController = TextEditingController();
  TextEditingController serieController = TextEditingController();
  TextEditingController folioInicialController = TextEditingController();

  List<SelectedModel> tipos = [
    SelectedModel(value: 'cfdi', text: 'CFDI'),
    SelectedModel(value: 'nomina', text: 'Nómina'),
  ];

  Rx<SelectedModel> tipoImpuestoSelected =
      SelectedModel(value: 'CFDI', text: 'CFDI').obs;

  RxBool loading = false.obs;

  void onStepContinue() {
    if (currentStep.value < 1) {
      currentStep.value++;
      refresh();
    }
  }

  void onStepCancel() {
    if (currentStep.value > 0) {
      currentStep.value--;
      refresh();
    }
  }

  void onStepTapped(value) {
    currentStep.value = value;
    refresh();
  }

  bool validarPrimerForm() {
    if (primeroFormKey.currentState!.validate()) {
      onStepContinue();
      return true;
    }
    return false;
  }

  onChangedTipoImpuesto(SelectedModel? value) {
    if (value != null) {
      tipoImpuestoSelected.value = value;
    }
  }

  Future validarSegundoForm() async {
    final isValid = validarPrimerForm();

    if (!isValid) {
      onStepTapped(0);
      return;
    }

    final isValid2 = segundoFormKey.currentState!.validate();

    if (!isValid2) {
      onStepTapped(1);
      return;
    }

    await guardar();
  }

  Future guardar() async {
    try {
      loading.value = true;
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'series/registrar',
        method: Method.POST,
        body: {
          'descripcion': descripcionController.text,
          'serie': serieController.text,
          'folio': folioInicialController.text,
          'tipo': tipoImpuestoSelected.value.value ?? '',
          'nombre': nombreSocursalController.text,
          'calle': calleController.text,
          'numero_exterior': numeroExteriorController.text,
          'numero_interior': numeroInteriorController.text,
          'colonia': coloniaController.text,
          'municipio': municipioController.text,
          'estado': estadoSelected.value?.value ?? '',
          'codigo_postal': codigoPostalController.text,
          'id_usuario': usuarioController.usuario.value.idUsuario,
        },
      );

      Get.back();
      seriesListaController.pagingController.refresh();

      final message = await response['message'];

      Get.snackbar(
        'Series',
        message,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return;
    } catch (e) {
      Get.snackbar(
        'Series',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
    }
  }

  String? validateDrop(SelectedModel? value) {
    if (value == null) {
      return 'Seleccione una opción.';
    }

    return null;
  }

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    await getEstados();
    loading.value = false;
    refresh();
  }

  Future getEstados() async {
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'estados',
        method: Method.GET,
      );

      response.forEach((estado) {
        estados.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });
    } catch (e) {
      Get.snackbar(
        'Estados',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
