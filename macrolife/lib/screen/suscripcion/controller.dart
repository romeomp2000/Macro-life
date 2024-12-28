import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/AplePay.dart';
import 'package:macrolife/helpers/StripePaymentHandle.dart';
import 'package:macrolife/helpers/configuraciones.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/widgets/button_paypal.dart';
import 'package:macrolife/widgets/layout.dart';
import 'package:pay/pay.dart';

class SuscripcionController extends GetxController {
  final ConfiguracionesController configuraiones = Get.find();
  final sucripcion = 'Mensual'.obs;
  final UsuarioController usuarioController = Get.find();
  final EscanearAlimentosController escanearAlimentoController =
      Get.put(EscanearAlimentosController());
  final RxDouble totalAPagar = 0.0.obs;

  RxList<String> images = <String>[].obs;

  RxString imagenUrl =
      'assets/images/pantalla_escaneo_alimentos_1125x2436_6 (1).jpg'.obs;

  @override
  void onInit() {
    totalAPagar.value =
        configuraiones.configuraciones.value.suscripcion?.mensual ?? 0.0;

    images.add('assets/images/imagen_slider_1.jpg');
    images.add('assets/images/imagen_slider_2.jpg');
    images.add('assets/images/imagen_slider_3.jpg');
    images.add('assets/images/imagen_slider_4.jpg');

    super.onInit();
    configuraiones.configuraciones.value.suscripcion?.mensual ?? 0.0.obs;
  }

  void suscribirseUsuario({
    required double total,
    required String producto,
    required String identificador,
    required String metodoPago,
  }) async {
    try {
      final apiService = ApiService();
      await apiService.fetchData(
        'suscripcion/usuario',
        method: Method.POST,
        body: {
          "idUsuario": usuarioController.usuario.value.sId,
          "producto": producto,
          'total': total,
          'identificador': identificador,
          'metodoPago': metodoPago,
        },
      );

      Get.back();
      Get.back();
      escanearAlimentoController.ayudaEscanear();
      usuarioController.usuario.value.vencidoSup = true;
      usuarioController.usuario.refresh();
    } catch (e) {
      print(e);
    }
  }

  void pagar() {
    Get.bottomSheet(
      isDismissible: true, // Permite cerrar al presionar fuera
      enableDrag: true, // Permite deslizar para cerrar
      persistent: true,
      isScrollControlled: true,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: Text(
                    'Pagar con:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonPayPal(
                  precio: totalAPagar.value,
                  producto: 'MACRO LIFE',
                  onSuccess: (e) {
                    suscribirseUsuario(
                      total: totalAPagar.value,
                      producto: sucripcion.value,
                      identificador: 'paypal',
                      metodoPago: 'PayPal',
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  onPressed: () async {
                    final prueba = StripeController();

                    prueba.makePay(
                      total: totalAPagar.value,
                      producto: sucripcion.value,
                    );
                    // get the pay instince
                  },
                  child: Image.asset(
                    'assets/icons/logo_stripe_800x241_original.png',
                    height: 20,
                    width: Get.width,
                  ),
                ),
                const SizedBox(height: 20),
                if (Platform.isIOS)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      final pay = Pay({
                        PayProvider.apple_pay:
                            PaymentConfiguration.fromJsonString(defaultApplePay)
                      });

                      // show it to the user, and get the payload
                      final payload =
                          await pay.showPaymentSelector(PayProvider.apple_pay, [
                        PaymentItem(
                          type: PaymentItemType.total,
                          status: PaymentItemStatus.final_price,
                          amount: totalAPagar.value.toString(),
                          label: 'MACRO LIFE',
                        )
                      ]);

                      // use the payload to get the stripe token
                      final stripeToken =
                          await Stripe.instance.createApplePayToken(payload);

                      // send the stripe token id to the server side
                      final tokenId = stripeToken.id;

                      suscribirseUsuario(
                        total: totalAPagar.value,
                        producto: sucripcion.value,
                        identificador: tokenId,
                        metodoPago: 'Apple Pay',
                      );
                    },
                    child: Image.asset(
                      'assets/icons/logo_apple_pay_800x135_original.png',
                      height: 20,
                      width: Get.width,
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
