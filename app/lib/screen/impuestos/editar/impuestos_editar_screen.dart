import 'package:fep/screen/impuestos/editar/impuestos_editar_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/custom_drop_search.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:fep/widgets/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImpuestosEditarScreen extends StatelessWidget {
  const ImpuestosEditarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Impuestos'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Eliminar impuesto',
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () =>
                Get.find<ImpuestosEditarController>().deleteImpuesto(),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Editar impuesto',
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
    return GetBuilder<ImpuestosEditarController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                Obx(
                  () => controller.loading.value
                      ? const LinearProgressIndicator()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                FadeInAnimation(
                  delay: 1.0,
                  child: CustomDropdownSearch(
                    label: 'Tipo de impuesto',
                    items: controller.tiposImpuestos,
                    selectedItem: controller.tipoImpuestoSelected.value,
                    onChanged: controller.tiposImpuestosChangue,
                    validator: controller.validateDrop,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.1,
                  child: CustomTextFormField(
                    label: 'Nombre del impuesto',
                    controller: controller.nombreImpuestoController,
                    validator: controller.validateNombreImpuesto,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.2,
                  child: CustomDropdownSearch(
                    label: 'Impuesto',
                    items: controller.impuestos,
                    selectedItem: controller.impuestoSelected.value,
                    onChanged: controller.impuestosChangue,
                    validator: controller.validateDrop,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.3,
                  child: CustomDropdownSearch(
                    label: 'Tipo de factor',
                    items: controller.tiposFactor,
                    selectedItem: controller.tipoFactorSelected.value,
                    validator: controller.validateDrop,
                    onChanged: controller.tipoFactosChangue,
                  ),
                ),
                if (controller.tasaCuota.value)
                  FadeInAnimation(
                    delay: 1.3,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomDropdownSearch(
                            label: 'Tasa o cuota',
                            items: controller.tasaOCuota,
                            selectedItem: controller.tasaOCuotaSelected.value,
                            validator: controller.validateDrop,
                            onChanged: (value) =>
                                controller.tasaOCuotaSelected.value = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (controller.cuotaIeps.value)
                  FadeInAnimation(
                    delay: 1.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFormField(
                            label: 'Tasa o cuota',
                            controller: controller.cuotaIepsController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo requerido';
                              }
                              if (double.parse(value) < 0.0 ||
                                  double.parse(value) > 43.77) {
                                return 'Rango de 0.000000 - 43.770000';
                              }
                              return null;
                            }),
                        const SizedBox(height: 5),
                        const Text(
                          'IEPS Rango: 0.000000 - 43.770000',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                if (controller.cuotaIva.value)
                  FadeInAnimation(
                    delay: 1.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          label: 'Tasa o cuota',
                          controller: controller.cuotaIvaController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo requerido';
                            }
                            if (double.parse(value) < 0.0 ||
                                double.parse(value) > 0.16) {
                              return 'Rango de 0.000000 - 0.160000';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'IVA Rango: 0.000000 - 0.160000',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                if (controller.cuotaIsr.value)
                  FadeInAnimation(
                    delay: 1.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          label: 'Tasa o cuota',
                          controller: controller.cuotaIsrController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo requerido';
                            }
                            if (double.parse(value) < 0.0 ||
                                double.parse(value) > 0.35) {
                              return 'Rango de 0.000000 - 0.350000';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'ISR Rango: 0.000000 - 0.350000',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                if (controller.sinCuota.value)
                  const FadeInAnimation(
                    delay: 1.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'En IVA o ISR no se permite cuota',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 2.1,
                  child: CustomElevatedButton(
                    message: "Guardar",
                    function: () => controller.guardarImpuestos(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
