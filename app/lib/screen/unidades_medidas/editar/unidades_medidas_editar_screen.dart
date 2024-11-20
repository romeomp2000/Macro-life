import 'package:fep/screen/unidades_medidas/editar/unidades_medidas_editar_controller.dart';
import 'package:fep/widgets/In_app_web_view_page.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/custom_drop_search.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:fep/widgets/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnidadesMedidasEditarScreen extends StatelessWidget {
  const UnidadesMedidasEditarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Unidades de Medida'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Eliminar Unidades de Medida',
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () =>
                Get.find<UnidadesMedidasEditarController>().delete(),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Editar Unidad de Medida',
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
    return GetBuilder<UnidadesMedidasEditarController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.formFormKey,
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
                  child: CustomTextFormField(
                    label: 'Unidad (Nombre)',
                    controller: controller.unidadController,
                    validator: controller.validateInput,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.2,
                  child: CustomTextFormField(
                    label: 'Descripción',
                    controller: controller.descripcionController,
                    validator: controller.validateInput,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.3,
                  child: CustomTextFormField(
                    label: 'Clave Unidad SAT',
                    controller: controller.cveUnidadSatController,
                    validator: controller.validateInput,
                    suffixIcon: IconButton(
                      tooltip: 'Asocia tu unidad al CATALOGO del SAT',
                      icon: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.search,
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          () => const InAppWebViewPage(
                            url: 'http://pys.sat.gob.mx/PyS/catUnidades.aspx',
                            titulo: 'Asocia tu unidad al CATALOGO del SAT',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.4,
                  child: Obx(
                    () => CustomDropdownSearch(
                      label: 'Estatus',
                      items: controller.estatus,
                      selectedItem: controller.estatusSelected.value,
                      validator: controller.validateDrop,
                      onChanged: (value) {
                        controller.estatusSelected.value = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: 1.5,
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
