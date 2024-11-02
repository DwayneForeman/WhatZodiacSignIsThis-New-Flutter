import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsignisthis/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/subscription/purchase_api.dart';
import 'package:whatsignisthis/subscription/subscription_controller.dart';
import 'package:whatsignisthis/utils/variables.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseApi.init();
  await SubscriptionController().refreshCustomerInfo();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(GlobalVariables());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What Sign Is This?',
      home: WelcomeScreen(),
    );
  }
}
