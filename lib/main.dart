import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/welcome_screen.dart';
import 'package:whatsignisthis/subscription/purchase_api.dart';
import 'package:whatsignisthis/subscription/subscription_controller.dart';
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

  Workmanager().initialize(
    // The top level function, aka callbackDispatcher
      callbackDispatcher,
      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: false
  );

  // Periodic task registration
  Workmanager().registerPeriodicTask(
    initialDelay: const Duration(minutes: 2),
    "2",
    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",
    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: const Duration(minutes: 15),
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


