import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/pago/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

class PagoVista extends StatelessWidget {
  const PagoVista({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PagoController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        // elevation: 0,
      ),
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Prueba  Macro Life gratis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(Icons.done),
                        ),
                        Text(
                          'No hay pagos pendientes',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  buttonTest('Prueba gratis', () {
                    Get.offAllNamed('/layout');
                  }, true),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 2),
                    child: Text(
                      'Solo \$${controller.anualPrice.toStringAsFixed(2)} por año (\$${((controller.anualPrice) / 12).toStringAsFixed(2)}/mes)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
