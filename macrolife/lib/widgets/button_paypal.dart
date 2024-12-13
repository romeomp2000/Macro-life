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
                  "name": "$producto",
                  "quantity": 1,
                  "price": precio.toStringAsFixed(2),
                  "currency": "MXN"
                }
              ],
            },
            "description": "MACROLIFE - Pago de Servicios",
          }
        ],
        note: "MACRO LIFE - Pago de Servicios",
        onSuccess: (Map result) {
          onSuccess(result);
        },
        onError: (dynamic error) {},
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
          color: const Color(0xFFFFC439), // color personalizado
        ),
        child: const Center(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: ' Pay',
                  style: TextStyle(
                    color: Color(0xFF003087),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'Pal',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF009CDE),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
