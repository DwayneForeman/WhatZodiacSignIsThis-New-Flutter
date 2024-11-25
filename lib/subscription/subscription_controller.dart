import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:whatsignisthis/screens/home_screen.dart';

enum Entitlement {free, premium}

class SubscriptionController extends GetxController {
  var entitlement = Entitlement.free.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomerInfo();
  }

  Future<void> fetchCustomerInfo() async {
    try {
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        updateEntitlementStatus(customerInfo);
      });
    } catch (e) {
      debugPrint("Error fetching customer info: $e");
    }
  }


  Future<void> refreshCustomerInfo() async {
    try {
      await Purchases.invalidateCustomerInfoCache();
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      updateEntitlementStatus(customerInfo);
    } catch (e) {
      debugPrint("Error refreshing customer info: $e");
    }
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      updateEntitlementStatus(customerInfo);
      if (entitlement.value == Entitlement.free) {
        Get.snackbar(
          'Restore Purchases',
          'No active subscriptions found.',
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Restore Purchases',
          'Subscriptions restored successfully.',
          colorText: Colors.white,
        );
        Get.offAll(const HomeScreen());
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error restoring purchase',
        colorText: Colors.white,
      );
    }
  }



  void updateEntitlementStatus(CustomerInfo customerInfo) {
    final entitlements = customerInfo.entitlements.active.values.toList();
    entitlement.value = entitlements.isEmpty ? Entitlement.free : Entitlement.premium;
  }
}
