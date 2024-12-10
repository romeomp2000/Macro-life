import 'package:cached_network_image/cached_network_image.dart';
import 'package:fep/models/alimento.model.dart';
import 'package:fep/screen/IngredientesEditar/screen.dart';
import 'package:fep/screen/IngredientesEditarNombre/screen.dart';
import 'package:fep/screen/nutricion/controller.dart';
import 'package:fep/widgets/puntuacion_salud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutricionScreen extends StatelessWidget {
  final AlimentoModel alimento;
  const NutricionScreen({super.key, required this.alimento});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NutricionController());
    controller.porcion.value = alimento.porcion;
    controller.id.value = alimento.id;
    controller.nombre.value = alimento.name;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: alimento.imageUrl,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: Get.width,
            height: 600,
          ),
          DraggableScrollableSheet(
            snap: false,
            initialChildSize:
                0.5, // Tamaño inicial del contenedor (50% de la pantalla)
            minChildSize: 0.5, // Tamaño mínimo (20% de la pantalla)
            maxChildSize: 0.95, // Tamaño máximo (90% de la pantalla)
            builder: (context, scrollController) {
              return Container(
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: alimento.favorito == true
                                  ? const Icon(Icons.bookmark)
                                  : const Icon(Icons.bookmark_border)),
                          const SizedBox(width: 10),
                          Text(alimento.time)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                final nombreRaname = await Get.to(
                                  () => IngredienteEditarNombreScreen(
                                    nombre: alimento.name,
                                    id: alimento.id,
                                  ),
                                );

                                if (nombreRaname != null) {
                                  controller.nombre.value = nombreRaname!;
                                }
                              },
                              child: Obx(
                                () => Text(
                                  '${controller.nombre.value}${controller.porcion.value != 1 ? ' x${controller.porcion.value}' : ''}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius:
                                  BorderRadius.circular(20), // Borde redondeado
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (controller.porcion.value == 0.0) return;

                                    if (controller.porcion.value == 0.25) {
                                      controller.porcion.value =
                                          controller.porcion.value - 0.25;
                                      return;
                                    }

                                    if (controller.porcion.value == 0.5) {
                                      controller.porcion.value =
                                          controller.porcion.value - 0.25;
                                      return;
                                    }

                                    controller.porcion.value =
                                        controller.porcion.value - 0.5;
                                  },
                                  iconSize: 18,
                                ),
                                Obx(
                                  () => Text(
                                    '${controller.porcion.value}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    if (controller.porcion.value == 0.0) return;

                                    if (controller.porcion.value == 0.25) {
                                      controller.porcion.value =
                                          controller.porcion.value + 0.25;
                                      return;
                                    }

                                    if (controller.porcion.value == 0.5) {
                                      controller.porcion.value =
                                          controller.porcion.value + 0.5;
                                      return;
                                    }

                                    controller.porcion.value =
                                        controller.porcion.value + 0.5;
                                  },
                                  iconSize: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12, // Color del borde
                            width: 1.0, // Grosor del borde
                          ),
                          borderRadius: BorderRadius.circular(
                              15), // Borde redondeado para todo el contenedor
                        ),
                        child: CupertinoListTile(
                          title: const Text('Calorías'),
                          subtitle: Text(
                            '${alimento.calories}g',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          leadingSize: 40,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // Borde redondeado
                              color: Colors.grey[100],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://macrolife.app/images/app/home/icono_flama_chica_negra_48x48_original.png', // Ícono de calorías
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NutritionalInfoRow(
                            icon:
                                'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png',
                            label: 'Proteína',
                            value: '${alimento.protein}g',
                          ),
                          NutritionalInfoRow(
                            icon:
                                'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png',
                            label: 'Carbohidratos',
                            value: '${alimento.carbs}g',
                          ),
                          NutritionalInfoRow(
                            icon:
                                'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png',
                            label: 'Grasas',
                            value: '${alimento.fats}g',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12, // Color del borde
                            width: 1.0, // Grosor del borde
                          ),
                          borderRadius: BorderRadius.circular(
                              15), // Borde redondeado para todo el contenedor
                        ),
                        child: CupertinoListTile(
                          onTap: () => Get.to(() => PuntuacionSaludScreen(
                              puntuacion: alimento.puntuacionSalud)),
                          title: const Text('Puntuación de salud'),
                          subtitle: LinearProgressIndicator(
                            value: alimento.puntuacionSalud.score * 0.100,
                            color: Colors.green,
                          ),
                          trailing: Text(
                            '${alimento.puntuacionSalud.score}/10',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          leadingSize: 40,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // Borde redondeado
                              color: Colors.grey[100],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://macrolife.app/images/app/home/iconografia_metas_100x100_corazon.png', // Ícono de calorías
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Ingredientes',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8, // Espacio horizontal entre contenedores
                        runSpacing: 8, // Espacio vertical entre filas
                        children: [
                          for (var ingrediente in alimento.ingredientes)
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => IngredienteEditarScreen(
                                    ingrediente: ingrediente,
                                  ),
                                );
                              },
                              child: NutritionalInfoRow(
                                label: '${ingrediente.nombre}',
                                value: '${ingrediente.calorias}g',
                              ),
                            )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: Get.height - 88,
            child: Container(
              decoration: const BoxDecoration(
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.black12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: Get.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://macrolife.app/images/app/home/icono_inteligencia_artificial_120x120_negro.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                // Usar Wrap para manejar el texto largo
                                const Text(
                                  'Corregir\n resultados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                  softWrap:
                                      true, // Habilitar el ajuste de línea
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.actualizarComidaAlimento();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Guardar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: IconButton(
                        iconSize: 23,
                        color: Colors.white,
                        icon: const Icon(Icons.keyboard_backspace),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Text(
                      'Nutrición',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: IconButton(
                            iconSize: 23,
                            color: Colors.white,
                            icon: const Icon(Icons.ios_share),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: PopupMenuButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 23,
                              color: Colors.white,
                            ),
                            onSelected: (value) {
                              // Acción cuando se selecciona una opción
                              if (value == 'Reportar comida') {
                                // Lógica para Reportar comida
                              } else if (value == 'Eliminar alimento') {
                                // Lógica para Eliminar alimento
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'Reportar comida',
                                child: Row(
                                  children: [
                                    Text('Reportar comida'),
                                    SizedBox(width: 10),
                                    Icon(Icons.comment),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Eliminar alimento',
                                child: Row(
                                  children: [
                                    Text(
                                      'Eliminar alimento',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NutritionalInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String? icon;

  const NutritionalInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Get.width / 3) - 16,
      // height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12, // Color del borde
          width: 1.0, // Grosor del borde
        ),
        borderRadius: BorderRadius.circular(
            15), // Borde redondeado para todo el contenedor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null)
                Container(
                  color: Colors.grey[100],
                  child: CachedNetworkImage(
                    imageUrl: icon!,
                    width: 12,
                    height: 12,
                  ),
                ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 0),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.edit, size: 12, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
