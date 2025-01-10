import 'package:flutter/material.dart';
import 'package:macrolife/screen/widgets/controller.dart';

class WidgetsView extends StatelessWidget {
  const WidgetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WidgetPreferenciasController();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                controller.crear();
              },
              child: Text('Crear Live'),
            ),
            TextButton(
              onPressed: () {
                controller.liveController.eliminar();
              },
              child: Text('Eliminar Live'),
            ),
          ],
        ),
      ),
    );
  }
}
