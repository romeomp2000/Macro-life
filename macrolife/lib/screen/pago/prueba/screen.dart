import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

class PantallaExito extends StatelessWidget {
  const PantallaExito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    'assets/images/logo_macrolife_vertical_negro_730x315_nuevo_1.png',
                    width: 250,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'A partir de ahora podrás usar la aplicación de Macro Life con todas sus funciones.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            )),
            buttonTest('Ir al home', () {
              Get.offAndToNamed('/layout');
            }, true)
          ],
        ),
      ),
    );
  }
}

class PagoExitosoController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
