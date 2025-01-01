import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/welcome_screen.dart';
import 'package:whatsignisthis/subscription/purchase_api.dart';
import 'package:whatsignisthis/subscription/subscription_controller.dart';
import 'package:whatsignisthis/utils/functions/get_next_8AM.dart';
import 'package:whatsignisthis/utils/functions/get_next_8PM.dart';
import 'package:whatsignisthis/utils/functions/get_time_zone.dart';
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

  int eveningDelay = getDifferenceToNext8PMInSeconds();
  int morningDelay = getDifferenceToNext8AMInSeconds();
  String timezone = getCurrentTimeZone();
  debugPrint("Timezone is $timezone");

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  //Morning notification task
  Workmanager().registerPeriodicTask(
    "1",
    "morningNotification",
    initialDelay: Duration(seconds: morningDelay),
    frequency: const Duration(seconds: 60*24*24),
  );

  // Evening notification task
  Workmanager().registerPeriodicTask(
    "2",
    "eveningNotification",
    initialDelay: Duration(seconds: eveningDelay),
    frequency: const Duration(seconds: 60*24*24),
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


