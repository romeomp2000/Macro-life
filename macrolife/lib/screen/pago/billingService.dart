import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:macrolife/screen/pago/controller.dart';
import 'package:macrolife/screen/pago/controllerSuscripcion.dart';

class InAppPurchaseUtils extends GetxController {
  InAppPurchaseUtils._();

  // Singleton instance
  static final InAppPurchaseUtils _instance = InAppPurchaseUtils._();

  // Getter to access the instance
  static InAppPurchaseUtils get inAppPurchaseUtilsInstance => _instance;

  // Create a private variable
  InAppPurchase iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> purchasesSubscription;

  @override
  void onInit() async {
    super.onInit();
    await initialize();
  }

  @override
  void onClose() {
    purchasesSubscription.cancel();
    super.onClose();
  }

  Future<void> initialize() async {
    if (!(await iap.isAvailable())) return;

    purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        purchasesSubscription.cancel();
      },
      onError: (error) {},
    );
  }

  Future<List<SubscriptionData>> getProducts(Set<String> idS) async {
    try {
      final bool available = await iap.isAvailable();

      if (!available) {
        return [];
      }

      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(idS);

      List<ProductDetails> productsData = response.productDetails;
      List<SubscriptionData> products = [];
      if (productsData.isNotEmpty) {
        products.clear();
        for (ProductDetails e in productsData) {
          SubscriptionData data = SubscriptionData(
            nombre: e.title,
            data: e,
          );
          products.add(data);
        }
      }
      return products;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

  void purchaseProduct(String productId) {}

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (int index = 0; index < purchaseDetailsList.length; index++) {
      var purchaseStatus = purchaseDetailsList[index].status;
      // print(purchaseDetailsList.length);
      // switch (purchaseDetailsList[index].status) {
      //   case PurchaseStatus.pending:
      //     print(' Compra en proceso');
      //     continue;
      //   case PurchaseStatus.error:
      //     print(purchaseDetailsList[index].error);
      //     print('Error al comprar ');
      //     break;
      //   case PurchaseStatus.canceled:
      //     print(' Compra cancelada');
      //     break;
      //   case PurchaseStatus.purchased:
      //     // final controllerSubscription = Get.put(SubscriptionController());
      //     // final controllerPago = Get.put(PagoController());

      //     // controllerSubscription.suscribirseUsuario(
      //     //     identificador: purchaseDetailsList[index].purchaseID ?? '1111',
      //     //     total: controllerPago.anualPrice.value,
      //     //     producto: controllerPago.sucripcion.value == 'Plan anual'
      //     //         ? 'Anual'
      //     //         : 'Mensual',
      //     //     metodoPago: GetPlatform.isIOS ? 'Apple Pay' : 'Google Pay',
      //     //     fechaCompra: purchaseDetailsList[index].transactionDate);
      //     print(' Compra completa ');
      //     break;
      //   case PurchaseStatus.restored:
      //     print(' compras restablecidas ');
      //     break;
      // }

      // if (purchaseDetailsList[index].pendingCompletePurchase) {
      await iap.completePurchase(purchaseDetailsList[index]).then((value) {
        if (purchaseStatus == PurchaseStatus.purchased) {
          //on purchase success you can call your logic and your API here.
          //Método para completar la compra en la api, esto se debe de cambiar para otros proyectos
          final controllerSubscription = Get.put(SubscriptionController());
          final controllerPago = Get.put(PagoController());

          controllerSubscription.suscribirseUsuario(
              identificador: purchaseDetailsList[index].purchaseID ?? '1111',
              total: controllerPago.anualPrice.value,
              producto: controllerPago.sucripcion.value == 'Plan anual'
                  ? 'Anual'
                  : 'Mensual',
              metodoPago: GetPlatform.isIOS ? 'Apple Pay' : 'Google Pay',
              fechaCompra: purchaseDetailsList[index].transactionDate);
          //---------
        }
      });
      // }
    }
  }

  Future<void> buyNonConsumableProduct(ProductDetails productDetails) async {
    try {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      await iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      // Handle purchase error
      if (kDebugMode) {
        print('Failed to buy plan: $e');
      }
    }
  }

  Future<void> buyConsumableProduct(ProductDetails productDetails) async {
    try {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      await iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
      // await iap.completePurchase(purchaseParam);
    } catch (e) {
      // Handle purchase error
      if (kDebugMode) {
        print('Failed to buy plan: $e');
      }
    }
  }

  restorePurchases() async {
    try {
      await iap.restorePurchases();
    } catch (error) {
      //you can handle error if restore purchase fails
    }
  }
}

class SubscriptionData {
  final String nombre;
  final ProductDetails data;

  SubscriptionData({required this.nombre, required this.data});
}
