import 'package:fep/config/theme.dart';
import 'package:fep/screen/series/nuevo/series_nuevo_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/custom_drop_search.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesNuevoScreen extends StatelessWidget {
  const SeriesNuevoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Series'),
        automaticallyImplyLeading: false,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Nueva serie',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FormularioImpuestos(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioImpuestos extends StatelessWidget {
  const FormularioImpuestos({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeriesNuevoController>(
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
                    if (controller.currentStep.value != 1)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenTheme1_,
                        ),
                        onPressed: controller.validarPrimerForm,
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
                DatosDeLaSerieForm(controller),
                DatosDeSocursal(controller),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              message: "Guardar",
              function: () => controller.validarSegundoForm(),
            ),
          ],
        );
      },
    );
  }

  Step DatosDeLaSerieForm(SeriesNuevoController controller) {
    return Step(
      title: const Text(
        'DATOS DE LA SERIE',
        style: TextStyle(fontSize: 12),
      ),
      content: Form(
        key: controller.primeroFormKey,
        child: Column(
          children: [
            const SizedBox(height: 5),
            CustomTextFormField(
              label: 'Descripción',
              controller: controller.descripcionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Serie',
              controller: controller.serieController,
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
                label: 'Tipo',
                items: controller.tipos,
                selectedItem: controller.tipoImpuestoSelected.value,
                validator: controller.validateDrop,
                onChanged: controller.onChangedTipoImpuesto,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Folio inicial',
              controller: controller.folioInicialController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

Step DatosDeSocursal(SeriesNuevoController controller) {
  return Step(
    state: StepState.editing,
    title: const Text(
      'DATOS DE SOCURSAL',
      style: TextStyle(fontSize: 12),
    ),
    subtitle: const Text(
      'Capture los datos de la sucursal de la serie, si necesita diferenciar los datos de facturación. ',
      style: TextStyle(
        fontSize: 11,
        color: Colors.black54,
      ),
    ),
    content: SingleChildScrollView(
      child: Form(
        key: controller.segundoFormKey,
        child: Column(
          children: [
            const SizedBox(height: 5),
            CustomTextFormField(
              label: 'Nombre Sucursal',
              controller: controller.nombreSocursalController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Calle',
              controller: controller.calleController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Número exterior',
              controller: controller.numeroExteriorController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Número interior',
              controller: controller.numeroInteriorController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Colonia',
              controller: controller.coloniaController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Municipio',
              controller: controller.municipioController,
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
              label: 'Código postal',
              controller: controller.codigoPostalController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    ),
  );
}
