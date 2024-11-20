import 'dart:math';

import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/funciones_globales.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/clientes/lista/clientes_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientesEditarController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  final ClientesListaController listaController = Get.find();
  final primeroFormKey = GlobalKey<FormState>();
  final argumentos = Get.arguments;

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

  List<SelectedModel> optionsEstatus = [
    SelectedModel(value: 'activo', text: 'Activo'),
    SelectedModel(value: 'Inactivo', text: 'Inactivo'),
  ];

  Rx<SelectedModel?> estatusSelected = Rx<SelectedModel?>(null);

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
        'clientes/editar',
        method: Method.POST,
        body: {
          'id_registro': argumentos.idCliente,
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
          'estatus': estatusSelected.value?.value ?? '',
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
    cargarCliente();

    await Future.wait([
      FuncionesGlobales.getEstados().then((value) {
        estados.value = value;

        if (argumentos.idEstado != null &&
            argumentos.idEstado != '' &&
            argumentos.idEstado != 0) {
          estadoSelected.value = estados
              .firstWhere((element) => element.value == argumentos.idEstado);
        }
      }),
      FuncionesGlobales.getRegimen(personaSelected.value.value).then((value) {
        regimens.value = value;

        if (argumentos.regimenFiscal != null &&
            argumentos.regimenFiscal != '' &&
            argumentos.regimenFiscal != 0) {
          regimenSelected.value = regimens.firstWhere(
              (element) => element.value == argumentos.regimenFiscal);
        }
      }),
      FuncionesGlobales.getUso(personaSelected.value.value).then((value) {
        usoCfdis.value = value;

        if (argumentos.usocfdi != null &&
            argumentos.usocfdi != '' &&
            argumentos.usocfdi != 0) {
          usoCfdiSelected.value = usoCfdis
              .firstWhere((element) => element.value == argumentos.usocfdi);
        }
      }),
      FuncionesGlobales.getMetodosPago().then((value) {
        metodosPagos.value = value;

        if (argumentos.metodopago != null &&
            argumentos.metodopago != '' &&
            argumentos.metodopago != 0) {
          metodoPagoSelected.value = metodosPagos
              .firstWhere((element) => element.value == argumentos.metodopago);
        }
      }),
      FuncionesGlobales.getFormasPago().then((value) {
        formasPagos.value = value;

        if (argumentos.formapago != null &&
            argumentos.formapago != '' &&
            argumentos.formapago != 0) {
          formaPagoSelected.value = formasPagos
              .firstWhere((element) => element.value == argumentos.formapago);
        }
      }),
      FuncionesGlobales.getResidenciasFiscales().then((value) {
        resideniasFiscales.value = value;

        if (argumentos.residenciafiscal != null &&
            argumentos.residenciafiscal != '' &&
            argumentos.residenciafiscal != 0) {
          resideniaFiscalSelected.value = resideniasFiscales.firstWhere(
              (element) => element.value == argumentos.residenciafiscal);
        }
      }),
    ]);

    loading.value = false;
    refresh();
  }

  void cargarCliente() {
    try {
      if (argumentos.empresa != null) {
        empresaController.text = argumentos.empresa;
      }

      if (argumentos.razonSocial != null) {
        razonSocialController.text = argumentos.razonSocial;
      }

      if (argumentos.codigoPostal != null) {
        domicilioFiscalController.text = argumentos.codigoPostal;
      }

      if (argumentos.personalidad != null) {
        personaSelected.value = personas
            .firstWhere((element) => element.value == argumentos.personalidad);
      }

      if (argumentos.rfc != null) {
        rfcController.text = argumentos.rfc;
      }

      if (argumentos.direccion != null) {
        direccionController.text = argumentos.direccion;
      }

      if (argumentos.telefono != null) {
        telefonoController.text = argumentos.telefono;
      }

      if (argumentos.email != null) {
        emailController.text = argumentos.email;
      }

      if (argumentos.emailsCopia != null) {
        copiaEmailsController.text = argumentos.emailsCopia;
      }

      if (argumentos.comentarios != null) {
        comentariosController.text = argumentos.comentarios;
      }

      if (argumentos.numeroCliente != null) {
        numeroClienteController.text = argumentos.numeroCliente;
      }

      if (argumentos.numregidtrib != null) {
        identificacionFiscalController.text = argumentos.numregidtrib;
      }

      if (argumentos.estatus != null) {
        estatusSelected.value = optionsEstatus
            .firstWhere((element) => element.value == argumentos.estatus);
      }

      refresh();
    } on Exception catch (e) {
      print(e);
      Get.snackbar(
        'Clientes',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future delete() async {
    // Mostrar un diálogo de confirmación basado en la plataforma
    bool confirm = await FuncionesGlobales.deleteConfirmacion(
        '¿Estás seguro de que deseas eliminar este cliente?');

    // Si el usuario confirma, proceder con la eliminación
    if (confirm == true) {
      try {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'clientes/eliminar',
          method: Method.POST,
          body: {
            'id_registro': argumentos.idCliente,
          },
        );

        String mensaje =
            response['message'] ?? 'Cliente eliminado correctamente';

        Get.back();

        listaController.pagingController.refresh();
        Get.snackbar(
          'Impuestos',
          mensaje,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
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
}
