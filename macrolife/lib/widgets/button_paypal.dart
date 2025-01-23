import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/configuraciones.dart';

class ButtonPayPal extends StatelessWidget {
  final double precio;
  final String producto;
  final ValueChanged<Map> onSuccess;

  const ButtonPayPal({
    super.key,
    required this.precio,
    required this.producto,
    required this.onSuccess,
  });

  void payPalPagar() {
    final ConfiguracionesController configuracionesController = Get.find();

    Get.to(
      () => UsePaypal(
        sandboxMode: false,
        clientId:
            '${configuracionesController.configuraciones.value.payPal?.clientID}',
        secretKey:
            '${configuracionesController.configuraciones.value.payPal?.secretKey}',
        returnURL:
            'https://play.google.com/store/apps/details?id=mx.posibilidades.macrolife',
        cancelURL: 'https://www.google.com',
        transactions: [
          {
            "amount": {
              "total": precio.toStringAsFixed(2),
              "currency": "MXN",
              "details": {
                "subtotal": precio.toStringAsFixed(2),
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "item_list": {
              "items": [
                {
                  "name": producto,
                  "quantity": 1,
                  "price": precio.toStringAsFixed(2),
                  "currency": "MXN"
                }
              ],
            },
            "description": "MACRO LIFE - Pago de Servicios",
          }
        ],
        note: "MACRO LIFE - Pago de Servicios",
        onSuccess: (Map result) {
          onSuccess(result);
        },
        onError: (dynamic error) {
          print('Error: $error');
        },
        onCancel: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        payPalPagar();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black, // color personalizado
        ),
        child: Center(
          child: Image.asset('assets/icons/logo_paypal_800x194_original.png',
              height: 20),
        ),
      ),
    );
  }
}
