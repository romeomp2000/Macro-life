import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class StripeController extends GetxController {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePay() async {
    try {
      paymentIntent = await createPaymentIntent('19900');
      final paymentIntentClientSecret = paymentIntent?['client_secret'];

      if (paymentIntent != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Set to true for custom flow
            customFlow: false,
            // Main params
            merchantDisplayName: 'MACROLIFE',
            customerEphemeralKeySecret: paymentIntent?['ephemeralKey'],
            customerId: paymentIntent?['customer'],

            paymentIntentClientSecret: paymentIntentClientSecret,
            applePay: const PaymentSheetApplePay(
              merchantCountryCode: 'MX',
              buttonType: PlatformButtonType.pay,
            ),
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'MX',
              testEnv: true,
            ),
            style: ThemeMode.system,
          ),
        );

        await displayBottomSheet(paymentIntent!);
      }
    } catch (error) {
      if (kDebugMode) {
        print("$error");
      }
    }
  }

  Future<bool> displayBottomSheet(Map datos) async {
    final UsuarioController usuarioController = Get.find();
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) {
          usuarioController.usuario.value.vencidoSup = true;
          Get.back();
          Get.back();
          usuarioController.usuario.refresh();
          return true;
        },
      ).onError((error, stackTrace) {
        // snackbar('Error', 'El pago ha sido cancelado');
        return false;
      });
      return true;
    } on StripeException catch (e) {
      if (kDebugMode) {
        // snackbar('Pago fallido: ${e.error.localizedMessage}', '');
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error al mostrar la hoja de pago: $error");
        return false;
      }
    }
    return false;
  }

  Future<dynamic> createPaymentIntent(String monto) async {
    try {
      Map<String, dynamic> body = {
        "amount": monto,
        "currency": "MXN",
        'payment_method_types[]': 'card'
      };

      Stripe.publishableKey =
          'pk_test_51QUWUeIAwppv4H1a4RXT8tYB8EjIXA1rS7RwxWxswyBpf7k4i9jrfpoSNaL2jpbMiCuxtYEVQ05SXNZ3N7SorWrP00oucGKl9b';

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51QUWUeIAwppv4H1amtrSY2AAvq79TvUjgZ1v2scYLYfUJqABlpSIo8gSyDDo11gXTx7qjxdqIqejCkZUYfJFEQAV003mL5iJjp',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      return json.decode(response.body);
    } catch (error) {
      if (kDebugMode) {
        print('$error');
      }
      rethrow;
    }
  }

  // Future
}
