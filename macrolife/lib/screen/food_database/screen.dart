import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/food_database/controller.dart';
import 'package:macrolife/screen/food_database_alimento/screen.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';

class FoodDatabaseScreen extends StatelessWidget {
  const FoodDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodDatabaseController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Base de datos de alimentos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: TextEditingController(),
                  focus: true,
                  onChanged: (p0) {
                    controller.buscarAlimento(p0);
                  },
                  hinttext: 'Describe lo que comiste',
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.alimentos.isNotEmpty
                      ? Text(
                          'Seleccionar de la base de datos',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : SizedBox.shrink(),
                ),
                Obx(
                  () => controller.loading.value
                      ? LinearProgressIndicator()
                      : SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.alimentos.length,
                    itemBuilder: (context, index) {
                      final alimento = controller.alimentos[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              trailing: Icon(Icons.add),
                              onTap: () {
                                Get.to(FoodDatabaseAlimentoScreen(
                                  alimento: alimento,
                                ));
                              },
                              subtitleTextStyle: TextStyle(color: Colors.black),
                              title: Text(
                                alimento.nombre!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                                    width: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      '${alimento.calorias!.toStringAsFixed(0)} calorías')
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
