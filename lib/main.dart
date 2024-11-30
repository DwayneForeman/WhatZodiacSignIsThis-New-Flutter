import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/welcome_screen.dart';
import 'package:whatsignisthis/subscription/purchase_api.dart';
import 'package:whatsignisthis/subscription/subscription_controller.dart';
import 'package:whatsignisthis/utils/functions/get_next_8AM.dart';
import 'package:whatsignisthis/utils/functions/get_next_8PM.dart';
import 'package:whatsignisthis/utils/variables.dart';
import 'package:workmanager/workmanager.dart';

import 'notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseApi.init();
  await SubscriptionController().refreshCustomerInfo();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(GlobalVariables());

  //int initialDelay = getDifferenceToNext8PMInSeconds();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  //
  // Workmanager().registerPeriodicTask(
  //   initialDelay: Duration(seconds: initialDelay), "2", "EveningNotification", frequency: const Duration(days: 1),
  // );

  int eveningDelay = getDifferenceToNext8PMInSeconds();
  int morningDelay = getDifferenceToNext8AMInSeconds();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  // Morning notification task
  Workmanager().registerPeriodicTask(
    "1",
    "MorningNotification",
    initialDelay: Duration(seconds: morningDelay),
    frequency: const Duration(days: 1),
  );

  // Evening notification task
  Workmanager().registerPeriodicTask(
    "2",
    "EveningNotification",
    initialDelay: Duration(seconds: eveningDelay),
    frequency: const Duration(days: 1),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What Sign Is This?',
      home: WelcomeScreen(),
    );
  }
}


