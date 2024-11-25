import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, List<String>>> loadQuestions() async {
  // Load the JSON file from assets
  String jsonString = await rootBundle.loadString('assets/jokes/new_install.json');

  // Parse the JSON into a Map<String, dynamic>
  Map<String, dynamic> jsonMap = json.decode(jsonString);

  // Ensure each value is cast to a List<String>
  return jsonMap.map((key, value) {
    List<dynamic> dynamicList = value;
    List<String> stringList = List<String>.from(dynamicList);
    return MapEntry(key, stringList);
  });
}

Future<MapEntry<String, String>> getNthKeyValuePair(int n) async {
  // Load the questions from the JSON file
  Map<String, List<String>> questions = await loadQuestions();

  // Ensure the map has at least n entries
  if (n >= questions.length || n < 0) {
    throw Exception("Index out of range");
  }

  // Get the nth key-value pair from the map
  var iterator = questions.entries.iterator;

  // Move to the nth position
  for (int i = 0; i <= n; i++) {
    iterator.moveNext();
  }

  // The key is the zodiac sign, and the value is a list of questions
  String key = iterator.current.key;
  String value = iterator.current.value.first; // Get the first question only

  // Return the key (zodiac sign) and its first question as a MapEntry
  return MapEntry(key, value);
}