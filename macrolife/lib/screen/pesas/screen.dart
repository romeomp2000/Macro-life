import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PesasScreen extends StatelessWidget {
  const PesasScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
          'Ejercicio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registrar ejercicio',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoListTile(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  onTap: () {
                    Get.toNamed('/correr');
                  },
                  backgroundColor: Colors.grey[100],
                  title: Text('Ejecutar'),
                  subtitle: Text('Corriendo, trotando, esprintando, etc.'),
                  leading: Image.asset(
                    'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
                    width: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoListTile(
                  onTap: () {
                    Get.toNamed('/pesas');
                  },
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  backgroundColor: Colors.grey[100],
                  title: Text('Levantamiento de pesas'),
                  subtitle: Text('Máquinas, pesas, libres, etc.'),
                  leading: Image.asset(
                    'assets/icons/icono_registrar_ejercicio_solido_180x180_pesas.png',
                    width: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoListTile(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  backgroundColor: Colors.grey[100],
                  title: Text('Describir'),
                  subtitle: Text('Escribe tu entrenamiento en texto'),
                  leading: Image.asset(
                    'assets/icons/icono_registrar_ejercicio_solido_180x180_anotar.png',
                    width: 30,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
