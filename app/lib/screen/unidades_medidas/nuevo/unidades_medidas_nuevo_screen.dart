import 'package:fep/screen/unidades_medidas/nuevo/unidades_medidas_nuevo_controller.dart';
import 'package:fep/widgets/In_app_web_view_page.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:fep/widgets/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnidadesMedidasNuevoScreen extends StatelessWidget {
  const UnidadesMedidasNuevoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Impuestos'),
        automaticallyImplyLeading: false,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Nueva Unidad de Medida',
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
    return GetBuilder<UnidadesMedidasNuevoController>(
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
                // const InAppWebViewPage(
                //     url: 'http://pys.sat.gob.mx/PyS/catUnidades.aspx',
                //     titulo: 'Asocia tu unidad al CATALOGO del SAT'),
                FadeInAnimation(
                  delay: 1.4,
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
