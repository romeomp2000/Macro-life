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
      // appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Text(
              'Queremos que pruebes Macro Life gratis',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      extendBody: false,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buttonTest(
              'Prueba por \$0.0',
              () {
                Get.offAllNamed('/layout');
              },
              true,
            ),
          ],
        ),
      ),
    );
  }
}
