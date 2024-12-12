import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:macrolife/helpers/configuraciones.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;
  final ConfiguracionesController configuracionesController = Get.find();

  Future<void> makePayment() async {
    try {
      // Create payment intent data
      paymentIntent = await createPaymentIntent('100', 'MXN');
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
            testEnv: true,
            currencyCode: "MXN",
            merchantCountryCode: "MX",
          ),
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'MX',
            buttonType: PlatformButtonType.pay,
          ),
          merchantDisplayName: 'Flutterwings',
        ),
      );
      //Display payment sheet
      displayPaymentSheet();
    } catch (e) {
      print("exception $e");

      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        // Amount must be in smaller unit of currency
        // so we have multiply it by 100
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretKey =
          "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";
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('Error charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  displayPaymentSheet() async {
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      // Displaying snackbar for it
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("Paid successfully")),
      );
      paymentIntent = null;
    } on StripeException catch (e) {
      // If any error comes during payment
      // so payment will be cancelled
      print('Error: $e');

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text(" Payment Cancelled")),
      );
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }
}
//   Future<void> stripeMakePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('100', 'MXN');
//       await Stripe.instance
//           .initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           primaryButtonLabel: 'PRUEBA',

//           billingDetails: BillingDetails(
//             name: 'jesus',
//             email: 'jesus@posibilidades.com.mx',
//             phone: '2213425514',
//             address: Address(
//               city: 'PUEBLA',
//               country: 'MEXICO',
//               line1: '102 PONIENTE 114',
//               line2: '102 PONIENTE 114',
//               postalCode: '72200',
//               state: 'PUEBLA',
//             ),
//           ),
//           paymentIntentClientSecret:
//               paymentIntent!['client_secret'], //Gotten from payment intent
//           style: ThemeMode.dark,
//           merchantDisplayName: 'STRIPE',
//         ),
//       )
//           .then((value) {
//         print(value);
//       });

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       // 3. display the payment sheet.
//       await Stripe.instance.presentPaymentSheet();

//       Fluttertoast.showToast(msg: 'Payment succesfully completed');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         Fluttertoast.showToast(
//             msg: 'Error from Stripe: ${e.error.localizedMessage}');
//       } else {
//         Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
//       }
//     }
//   }

// //create Payment
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer ${configuracionesController.configuraciones.value.stripe?.secretKey}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

// //calculate Amount

// }
