import 'package:cached_network_image/cached_network_image.dart';
import 'package:fep/models/Puntuacion.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuntuacionSaludScreen extends StatelessWidget {
  final PuntuacionSalud puntuacion;

  const PuntuacionSaludScreen({
    super.key,
    required this.puntuacion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: IconButton(
              iconSize: 23,
              color: Colors.black,
              icon: const Icon(Icons.keyboard_backspace),
              onPressed: () => Get.back(),
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Puntuación de salud',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 25),
            Text(puntuacion.nombre,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(height: 25),
            Text('${puntuacion.descripcion}'),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12, // Color del borde
                  width: 1.0, // Grosor del borde
                ),
                borderRadius: BorderRadius.circular(
                    15), // Borde redondeado para todo el contenedor
              ),
              child: CupertinoListTile(
                title: const Text('Puntuación de salud'),
                subtitle: LinearProgressIndicator(
                  value: puntuacion.score * 0.100,
                  color: Colors.green,
                ),
                trailing: Text(
                  '${puntuacion.score}/10',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                leadingSize: 40,
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Borde redondeado
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
            const SizedBox(height: 25),
            Column(
              // Se puede usar Column para manejar el tamaño dinámico
              children: [
                for (var caracteristica in puntuacion.caracteristicas)
                  Column(
                    children: [
                      ListTile(
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(caracteristica),
                        ),
                        minLeadingWidth: 8,
                        leading: CachedNetworkImage(
                          imageUrl:
                              'https://macrolife.app/images/app/home/icono_registrar_ejercicio_68x68_intensidad.png',
                          width: 25,
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
