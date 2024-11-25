import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, List<String>>> loadQuestions() async {
  // Load the JSON file
  String jsonString = await rootBundle.loadString('assets/jokes/jokes.json');

  // Parse the JSON and convert lists to List<String>
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  return jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
}

Future<MapEntry<String, String>> getRandomQuestion() async {
  // Load the questions from the JSON file
  Map<String, List<String>> questions = await loadQuestions();

  // Get a random zodiac sign (key)
  Random random = Random();
  List<String> keys = questions.keys.toList();
  String randomKey = keys[random.nextInt(keys.length)];

  // Get a random question from the selected zodiac sign's list
  List<String> randomQuestions = questions[randomKey]!;
  String randomQuestion = randomQuestions[random.nextInt(randomQuestions.length)];

  return MapEntry(randomKey, randomQuestion); // Return key and question as a MapEntry
}
