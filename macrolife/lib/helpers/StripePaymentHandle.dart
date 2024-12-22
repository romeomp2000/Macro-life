import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:macrolife/helpers/configuraciones.dart';
import 'package:macrolife/screen/suscripcion/controller.dart';

class StripeController extends GetxController {
  Map<String, dynamic>? paymentIntent;
  final configuraiones = Get.put(ConfiguracionesController());
  final SuscripcionController suscripcionController =
      Get.put(SuscripcionController());
  Future<void> makePay({
    required double total,
    required String producto,
  }) async {
    try {
      String monto = calculateAmount(total);
      paymentIntent = await createPaymentIntent(monto);
      final paymentIntentClientSecret = paymentIntent?['client_secret'];

      if (paymentIntent != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Set to true for custom flow
            customFlow: false,
            // Main params
            merchantDisplayName: 'MACRO LIFE',
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

        await displayBottomSheet(
          paymentIntent!,
          total: total,
          producto: producto,
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print("$error");
      }
    }
  }

  calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();
    return calculatedAmount.toString();
  }

  Future<bool> displayBottomSheet(
    Map datos, {
    required double total,
    required String producto,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) {
          // usuarioController.usuario.value.vencidoSup = true;
          // Get.back();
          // Get.back();
          // usuarioController.usuario.refresh();
          suscripcionController.suscribirseUsuario(
            total: total,
            producto: producto,
            identificador: 'Stripe 12',
            metodoPago: 'Stripe',
          );
          return true;
        },
      ).onError((error, stackTrace) {
        // snackbar('Error', 'El pago ha sido cancelado');
        return false;
      });
      return true;
    } on StripeException catch (_) {
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
          configuraiones.configuraciones.value.stripe?.publicKey ?? '';

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          'Authorization':
              'Bearer ${configuraiones.configuraciones.value.stripe?.secretKey}',
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
