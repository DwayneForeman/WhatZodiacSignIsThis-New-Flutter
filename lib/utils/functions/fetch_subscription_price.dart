import 'package:flutter/cupertino.dart';

import '../../subscription/purchase_api.dart';
import '../variables.dart';

Future<void> fetchSubscriptionPrice() async {
  final offerings = await PurchaseApi.fetchOffers();

  if (offerings.isEmpty) {
    debugPrint('Offering is empty');
  } else {
    final packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    GlobalVariables.to.weeklyPrice.value = packages[0].storeProduct.priceString;
    GlobalVariables.to.monthlyPrice.value = packages[1].storeProduct.priceString;
    debugPrint('Weekly Price: ${GlobalVariables.to.weeklyPrice.value}\nMonthly Price: ${GlobalVariables.to.monthlyPrice.value}');
  }
}