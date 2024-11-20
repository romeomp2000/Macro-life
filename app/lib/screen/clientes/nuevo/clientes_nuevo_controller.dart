import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/funciones_globales.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/clientes/lista/clientes_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientesNuevoController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final ClientesListaController listaController = Get.find();
  final primeroFormKey = GlobalKey<FormState>();

  //? segundo
  final segundoFormKey = GlobalKey<FormState>();
  RxList<SelectedModel> estados = <SelectedModel>[].obs;
  Rx<SelectedModel?> estadoSelected = Rx<SelectedModel?>(null);

  TextEditingController direccionController = TextEditingController();
  TextEditingController domicilioFiscalController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeroClienteController = TextEditingController();
  TextEditingController copiaEmailsController = TextEditingController();
  TextEditingController comentariosController = TextEditingController();

  //? segundo

  RxInt currentStep = 0.obs;

//? primero
  TextEditingController razonSocialController = TextEditingController();
  TextEditingController empresaController = TextEditingController();
  TextEditingController rfcController = TextEditingController();

  List<SelectedModel> personas = [
    SelectedModel(value: 'fisica', text: 'Física'),
    SelectedModel(value: 'moral', text: 'Moral'),
  ];

  Rx<SelectedModel> personaSelected =
      SelectedModel(value: 'fisica', text: 'Física').obs;

  //? primero

//? tercero
  final terceroFormKey = GlobalKey<FormState>();
  RxList<SelectedModel> regimens = <SelectedModel>[].obs;
  Rx<SelectedModel?> regimenSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> usoCfdis = <SelectedModel>[].obs;
  Rx<SelectedModel?> usoCfdiSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> metodosPagos = <SelectedModel>[].obs;
  Rx<SelectedModel?> metodoPagoSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> formasPagos = <SelectedModel>[].obs;
  Rx<SelectedModel?> formaPagoSelected = Rx<SelectedModel?>(null);

  RxList<SelectedModel> resideniasFiscales = <SelectedModel>[].obs;
  Rx<SelectedModel?> resideniaFiscalSelected = Rx<SelectedModel?>(null);

  TextEditingController identificacionFiscalController =
      TextEditingController();

//? tercero

  RxBool loading = false.obs;

  void onStepContinue() {
    if (currentStep.value < 2) {
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
      personaSelected.value = value;
    }
  }

  bool validarSegundoForm() {
    if (segundoFormKey.currentState!.validate()) {
      onStepContinue();
      return true;
    }
    return false;
  }

  Future validarTerceroForm() async {
    final isValid = validarPrimerForm();

    if (!isValid) {
      onStepTapped(0);
      return;
    }

    final isValid2 = validarSegundoForm();

    if (!isValid2) {
      onStepTapped(1);
      return;
    }

    final isValid3 = terceroFormKey.currentState!.validate();

    if (!isValid3) {
      onStepTapped(2);
      return;
    }

    await guardar();
  }

  Future guardar() async {
    try {
      loading.value = true;
      final apiService = ApiService();
      final response = await apiService.fetchData(
        'clientes/registrar',
        method: Method.POST,
        body: {
          'empresa': empresaController.text,
          'razon_social': razonSocialController.text,
          'persona': personaSelected.value.value,
          'rfc': rfcController.text,
          'direccion': direccionController.text,
          'estado': estadoSelected.value?.value ?? '',
          'cp': domicilioFiscalController.text,
          'telefono': telefonoController.text,
          'email': emailController.text,
          'copia_email': copiaEmailsController.text,
          'usocfdi': usoCfdiSelected.value?.value ?? '',
          'metodo_pago': metodoPagoSelected.value?.value ?? '',
          'forma_pago': formaPagoSelected.value?.value ?? '',
          'residenciafiscal': resideniaFiscalSelected.value?.value ?? '',
          'numregIdtrib': identificacionFiscalController.text,
          'regimen': regimenSelected.value?.value ?? '',
          'numero_cliente': numeroClienteController.text,
          'comentarios': comentariosController.text,
          'id_usuario': usuarioController.usuario.value.idUsuario,
          'id_estado': estadoSelected.value?.value ?? '',
        },
      );

      Get.back();
      listaController.pagingController.refresh();

      final message = await response['message'];

      Get.snackbar(
        'Clientes',
        message,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return;
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Clientes',
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
    personaSelected.value = personas.first;
    loading.value = true;
    await Future.wait([
      FuncionesGlobales.getEstados().then((value) {
        estados.value = value;
      }),
      FuncionesGlobales.getRegimen(personaSelected.value.value).then((value) {
        regimens.value = value;
      }),
      FuncionesGlobales.getUso(personaSelected.value.value).then((value) {
        usoCfdis.value = value;
      }),
      FuncionesGlobales.getMetodosPago().then((value) {
        metodosPagos.value = value;

        if (value.isNotEmpty) {
          metodoPagoSelected.value = value.first;
        }
      }),
      FuncionesGlobales.getFormasPago().then((value) {
        formasPagos.value = value;

        if (value.isNotEmpty) {
          formaPagoSelected.value = value.first;
        }
      }),
      FuncionesGlobales.getResidenciasFiscales().then((value) {
        resideniasFiscales.value = value;
      }),
    ]);

    loading.value = false;
    refresh();
  }
}
