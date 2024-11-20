import 'package:fep/config/theme.dart';
import 'package:fep/screen/clientes/nuevo/clientes_nuevo_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/custom_drop_search.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ClientesNuevoScreen extends StatelessWidget {
  const ClientesNuevoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Clientes'),
        automaticallyImplyLeading: false,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Nuevo Cliente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Formulario(),
            ],
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesNuevoController>(
      builder: (controller) {
        return Column(
          children: [
            Obx(
              () => controller.loading.value
                  ? const LinearProgressIndicator()
                  : const SizedBox.shrink(),
            ),
            Stepper(
              elevation: 0,
              type: StepperType.vertical,
              currentStep: controller.currentStep.value,
              onStepContinue: controller.onStepContinue,
              onStepCancel: controller.onStepCancel,
              onStepTapped: controller.onStepTapped,
              margin: const EdgeInsets.all(0),
              controlsBuilder: (_, __) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    if (controller.currentStep.value == 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenTheme1_,
                        ),
                        onPressed: controller.validarPrimerForm,
                        child: const Text('Siguiente',
                            style: TextStyle(color: Colors.white)),
                      ),
                    if (controller.currentStep.value == 1)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenTheme1_,
                        ),
                        onPressed: controller.validarSegundoForm,
                        child: const Text('Siguiente',
                            style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
              ),
              stepIconBuilder: (stepIndex, _) => Text(
                '${stepIndex + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              connectorColor: WidgetStateProperty.all(greenTheme1_),
              controller: ScrollController(
                initialScrollOffset: 0,
                keepScrollOffset: true,
              ),
              steps: [
                datosCliente(controller),
                direccionFiscal(controller),
                datosFacturacion(controller),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              message: "Guardar",
              function: () => controller.validarTerceroForm(),
            ),
          ],
        );
      },
    );
  }

  Step datosCliente(ClientesNuevoController controller) {
    return Step(
      title: const Text(
        'DATOS DEL CLIENTE',
        style: TextStyle(fontSize: 12),
      ),
      content: Form(
        key: controller.primeroFormKey,
        child: Column(
          children: [
            const SizedBox(height: 5),
            CustomTextFormField(
              label: 'Empresa',
              controller: controller.empresaController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Razón social',
              controller: controller.razonSocialController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Persona',
                items: controller.personas,
                selectedItem: controller.personaSelected.value,
                validator: controller.validateDrop,
                onChanged: controller.onChangedTipoImpuesto,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'RFC',
              controller: controller.rfcController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'RFC: ',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      TextSpan(
                        text: 'XAXX010101000',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' (Si es público en general)',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //copiar en portapapeles
                    Clipboard.setData(ClipboardData(text: 'XAXX010101000'))
                        .then(
                      (value) {
                        Get.snackbar(
                          'RFC copiado en portapapeles',
                          'XAXX010101000',
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      },
                    );
                  },
                  child:
                      const Icon(Icons.copy, color: Colors.black54, size: 12),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'RFC: ',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      TextSpan(
                        text: 'XEXX010101000',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' (Para extranjeros, personas físicas o morales)',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //copiar en portapapeles
                    Clipboard.setData(ClipboardData(text: 'XEXX010101000'))
                        .then(
                      (value) {
                        Get.snackbar(
                          'RFC copiado en portapapeles',
                          'XEXX010101000',
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      },
                    );
                  },
                  child:
                      const Icon(Icons.copy, color: Colors.black54, size: 12),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Step direccionFiscal(ClientesNuevoController controller) {
  return Step(
    state: StepState.editing,
    title: const Text(
      'DIRECCIÓN FISCAL',
      style: TextStyle(fontSize: 12),
    ),
    content: SingleChildScrollView(
      child: Form(
        key: controller.segundoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            CustomTextFormField(
              label: 'Dirección',
              controller: controller.direccionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Estado',
                items: controller.estados,
                selectedItem: controller.estadoSelected.value,
                onChanged: (value) {
                  controller.estadoSelected.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Domicilio Fiscal (C.P.)',
              controller: controller.domicilioFiscalController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Teléfono',
              controller: controller.telefonoController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Email',
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Número de cliente',
              controller: controller.numeroClienteController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Enviar copia a estos e-mails ',
              controller: controller.copiaEmailsController,
            ),
            const SizedBox(height: 10),
            const Text(
              'Separe con (,) los correos ',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Comentarios',
              controller: controller.comentariosController,
            ),
          ],
        ),
      ),
    ),
  );
}

Step datosFacturacion(ClientesNuevoController controller) {
  return Step(
    state: StepState.editing,
    title: const Text(
      'DATOS DE FACTURACIÓN',
      style: TextStyle(fontSize: 12),
    ),
    content: SingleChildScrollView(
      child: Form(
        key: controller.terceroFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Obx(
              () => CustomDropdownSearch(
                label: 'Régimen Fiscal',
                items: controller.regimens,
                selectedItem: controller.regimenSelected.value,
                validator: controller.validateDrop,
                onChanged: (value) => controller.regimenSelected.value = value,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Uso del CFDI',
                items: controller.usoCfdis,
                selectedItem: controller.usoCfdiSelected.value,
                onChanged: (value) => controller.usoCfdiSelected.value = value,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Método de pago',
                items: controller.metodosPagos,
                selectedItem: controller.metodoPagoSelected.value,
                onChanged: (value) =>
                    controller.metodoPagoSelected.value = value,
                validator: controller.validateDrop,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Forma de pago',
                items: controller.formasPagos,
                selectedItem: controller.formaPagoSelected.value,
                onChanged: (value) =>
                    controller.formaPagoSelected.value = value,
                validator: controller.validateDrop,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
                'Si es cliente extranjero, capture estos 2 campos. (Si es mexicano, omita estos campos)',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 20),
            Obx(
              () => CustomDropdownSearch(
                label: 'Residencia fiscal',
                items: controller.resideniasFiscales,
                selectedItem: controller.resideniaFiscalSelected.value,
                onChanged: (value) =>
                    controller.resideniaFiscalSelected.value = value,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: controller.identificacionFiscalController,
              label: 'Núm. de registro de identificación fiscal',
            )
          ],
        ),
      ),
    ),
  );
}
