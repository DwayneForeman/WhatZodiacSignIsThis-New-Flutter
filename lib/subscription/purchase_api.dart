import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{
  static const _apiKeyAndroid = 'goog_ahJhqWqXrFPgGNOfSaYpzNYZWjJ';

  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(_apiKeyAndroid);
    await Purchases.configure(configuration);
  }

  static Future<List<Offering>> fetchOffers() async{
    try{
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException catch(e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async{
    try{
      await Purchases.purchasePackage(package);
      return true;
    } catch(e){
      return false;
    }
  }

}