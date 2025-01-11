import 'package:macrolife/models/Puntuacion.model.dart';
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
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Puntuación de salud',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            Text('${puntuacion.nombre}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text('${puntuacion.descripcion}'),
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
                  backgroundColor: Colors.grey[200],
                  value: (puntuacion.score ?? 0) * 0.100,
                  color: Colors.black,
                ),
                trailing: Text(
                  '${puntuacion.score}/10',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                leadingSize: 25,
                leading: Image.asset(
                  'assets/icons/icono_logros_alimenticios_outline_63x63_4.png',
                ),
              ),
            ),
            // ListTile(
            //   title: Container(
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Colors.grey[100],
            //       borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     ),
            //     child: Text('d'),
            //   ),
            //   minLeadingWidth: 20,
            //   leading: Image.asset(
            //     'assets/icons/icono_estrella_61x61_negro.png',
            //     width: 20,
            //   ),
            // ),
            Column(
              children: [
                for (var caracteristica in puntuacion.caracteristicas ?? [])
                  ListTile(
                    title: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(caracteristica),
                    ),
                    minLeadingWidth: 20,
                    leading: Image.asset(
                      'assets/icons/icono_estrella_61x61_negro.png',
                      width: 20,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
