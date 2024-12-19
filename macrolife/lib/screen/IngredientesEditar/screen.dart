import 'package:macrolife/models/ingrediente.model.dart';
import 'package:macrolife/screen/IngredientesEditar/controller.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IngredienteEditarScreen extends StatelessWidget {
  final IngredienteModel ingrediente;
  const IngredienteEditarScreen({super.key, required this.ingrediente});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IngredientesEditarController());
    controller.ingrediente.value = ingrediente;

    controller.calorias.text = ingrediente.calorias.toString();

    controller.protinae.text = ingrediente.proteina.toString();

    controller.carbohidratos.text = ingrediente.carbohidratos.toString();

    controller.grasas.text = ingrediente.grasas.toString();

    controller.chartData.value = [
      ChartData(
          'Proteínas', ingrediente.proteina!.toDouble(), Colors.redAccent),
      ChartData(
          'Grasas', ingrediente.grasas!.toDouble(), const Color(0xFFE69938)),
      ChartData('Carbohidratos', ingrediente.carbohidratos!.toDouble(),
          Colors.blueAccent)
    ];

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
          'Editar ingredientes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.grey[200],
            ),
            child: IconButton(
              onPressed: () => controller.eliminarIngrediente(),
              icon: const Icon(Icons.delete_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  '${ingrediente.nombre}',
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                CupertinoListTile(
                  leadingSize: 67,
                  padding: EdgeInsets.zero,
                  leading: CircularPercentIndicator(
                    radius: 33.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: const Icon(
                      Icons.local_fire_department,
                      size: 20,
                      color: Colors.black,
                    ),
                    progressColor: Colors.black,
                    backgroundColor: Colors.black12,
                  ),
                  title: const Text(
                    'Calorías',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.calorias,
                    onTap: () => controller.toggleKeyboardActions(true),
                    onEditingComplete: () =>
                        controller.toggleKeyboardActions(false),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(), // Borde cuando está enfocado
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CupertinoListTile(
                  leadingSize: 67,
                  padding: EdgeInsets.zero,
                  leading: CircularPercentIndicator(
                    radius: 33.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: Image.network(
                      'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png',
                      width: 15,
                    ),
                    progressColor: Colors.redAccent,
                    backgroundColor: Colors.black12,
                  ),
                  title: const Text(
                    'Objetivo de proteína',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.protinae,
                    onTap: () => controller.toggleKeyboardActions(true),
                    onEditingComplete: () =>
                        controller.toggleKeyboardActions(false),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(), // Borde cuando está enfocado
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CupertinoListTile(
                  leadingSize: 67,
                  padding: EdgeInsets.zero,
                  leading: CircularPercentIndicator(
                    radius: 33.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: Image.network(
                      'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png',
                      width: 15,
                    ),
                    progressColor: const Color(0xFFE69938),
                    backgroundColor: Colors.black12,
                  ),
                  title: const Text(
                    'Meta de carbohidratos',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.carbohidratos,
                    onTap: () => controller.toggleKeyboardActions(true),
                    onEditingComplete: () =>
                        controller.toggleKeyboardActions(false),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(), // Borde cuando está enfocado
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CupertinoListTile(
                  leadingSize: 67,
                  padding: EdgeInsets.zero,
                  leading: CircularPercentIndicator(
                    radius: 33.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: Image.network(
                      'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png',
                      width: 15,
                    ),
                    progressColor: Colors.blueAccent,
                    backgroundColor: Colors.black12,
                  ),
                  title: const Text(
                    'Objetivo de grasas',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.grasas,
                    onTap: () => controller.toggleKeyboardActions(true),
                    onEditingComplete: () =>
                        controller.toggleKeyboardActions(false),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(), // Borde cuando está enfocado
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
