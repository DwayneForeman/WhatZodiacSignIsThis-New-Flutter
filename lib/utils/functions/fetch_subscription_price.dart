import 'package:flutter/cupertino.dart';

import '../../subscription/purchase_api.dart';
import '../variables.dart';

Future<void> fetchSubscriptionPrice() async {
  final offerings = await PurchaseApi.fetchOffers();

  if (offerings.isEmpty) {
    debugPrint('Error Fetching Prices');
  } else {
    final packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    GlobalVariables.to.weeklyPrice.value = packages[0].storeProduct.priceString;
    debugPrint(GlobalVariables.to.weeklyPrice.value);
  }
}