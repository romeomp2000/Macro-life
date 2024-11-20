import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/series/lista/series_lista_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesEditarController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  // final SeriesListaController impuestosListaController = Get.find();
  final SeriesListaController seriesListaController = Get.find();
  final primeroFormKey = GlobalKey<FormState>();
  final argumentos = Get.arguments;

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

  List<SelectedModel> estatus = [
    SelectedModel(value: 'activo', text: 'Activo'),
    SelectedModel(value: 'inactivo', text: 'Inactivo'),
  ];

  Rx<SelectedModel?> estatusSelected =
      SelectedModel(value: 'activo', text: 'Activo').obs;

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
        'series/editar',
        method: Method.POST,
        body: {
          'id_registro': argumentos.idSerie,
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
          'estatus': estatusSelected.value?.value ?? '',
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

    try {
      if (argumentos != null) {
        descripcionController.text = argumentos.descripcion ?? '';
        serieController.text = argumentos.serie ?? '';
        folioInicialController.text = argumentos.folioInicial?.toString() ?? '';

        final SelectedModel tipoSelected = tipos.firstWhere(
          (element) => element.value == argumentos?.tipo,
          orElse: () => SelectedModel(value: 'cfdi', text: 'CFDI'),
        );
        tipoImpuestoSelected.value = tipoSelected;

        nombreSocursalController.text = argumentos.nombreSucursal ?? '';
        calleController.text = argumentos.calle ?? '';
        numeroExteriorController.text = argumentos.numeroExterior ?? '';
        numeroInteriorController.text = argumentos.numeroInterior ?? '';
        coloniaController.text = argumentos.colonia ?? '';
        municipioController.text = argumentos.municipio ?? '';
        codigoPostalController.text = argumentos.codigoPostal ?? '';

        if (argumentos?.idEstado != 0) {
          final SelectedModel? estado = estados.firstWhere(
            (element) => element.value == argumentos.idEstado,
          );

          estadoSelected.value = estado;
        }

        if (argumentos?.estatus != null) {
          final SelectedModel estatusSelected = estatus.firstWhere(
            (element) => element.value == argumentos?.estatus,
            orElse: () => SelectedModel(value: 'activo', text: 'Activo'),
          );

          this.estatusSelected!.value = estatusSelected;
        }
      }
    } on Exception catch (e) {
      Get.snackbar(
        'Series',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
      refresh();
    }
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

  Future deleteSerie() async {
    // Mostrar un diálogo de confirmación basado en la plataforma
    bool? confirm = await Get.dialog<bool>(
      GetPlatform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Confirmación'),
              content: const Text(
                  '¿Estás seguro de que deseas eliminar esta serie?'),
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
                  '¿Estás seguro de que deseas eliminar esta serie?'),
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
          'series/eliminar',
          method: Method.POST,
          body: {
            'id_registro': argumentos.idSerie,
          },
        );

        String mensaje = response['message'] ?? 'Impuesto eliminado';

        Get.back();

        seriesListaController.pagingController.refresh();
        Get.snackbar(
          'Series',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
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
  }
}
