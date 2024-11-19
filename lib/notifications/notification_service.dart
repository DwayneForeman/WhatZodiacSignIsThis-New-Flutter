import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const DarwinInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: iOS);
    flip.initialize(settings);
    String joke = await getRandomJoke();
    _showNotificationWithDefaultSound(flip, joke);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip, String joke) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'scheduled',
    'Daily Jokes',
    importance: Importance.max,
    priority: Priority.high,
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'What Sign is This?',
      joke,
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}

Future<String> getRandomJoke() async {
  // Load jokes from a local JSON file
  final String response = await rootBundle.loadString('assets/jokes/jokes.json');
  final Map<String, dynamic> jokesMap = jsonDecode(response);
  final Map<String, List<String>> castedJokesMap = {};

  jokesMap.forEach((key, value) {
    castedJokesMap[key] = List<String>.from(value);
  });

  final randomZodiac = castedJokesMap.keys.elementAt(Random().nextInt(castedJokesMap.keys.length));
  final randomJoke = castedJokesMap[randomZodiac]![Random().nextInt(castedJokesMap[randomZodiac]!.length)];

  return randomJoke;
}


