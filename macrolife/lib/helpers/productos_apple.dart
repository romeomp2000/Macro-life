import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseUtils extends GetxController {
  InAppPurchaseUtils._();

  static final InAppPurchaseUtils _instance = InAppPurchaseUtils._();

  static InAppPurchaseUtils get inAppPurchaseUtilsInstance => _instance;

  final InAppPurchase _iap = InAppPurchase.instance;

  void purchaseProduct(String productId) {
    // Implementation for purchasing a product
  }

  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  @override
  void onClose() {
    _purchasesSubscription.cancel();
    super.onClose();
  }

  Future<void> initialize() async {
    if (!(await _iap.isAvailable())) return;

    ///catch all purchase updates
    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        _purchasesSubscription.cancel();
      },
      onError: (error) {},
    );
  }

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    // Implement your logic for handling purchase updates here
  }
}
