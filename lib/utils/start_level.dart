import 'package:get/get.dart';

import '../screens/level1.dart';
import '../screens/level2.dart';
import '../screens/level3.dart';
import 'get_random_question.dart';

Future<void> startLevel(int level) async {
  MapEntry<String, String> question = await getRandomQuestion();
  switch(level){
    case 1:
      Get.offAll(Level1Screen(question: question));
    case 2:
      Get.offAll(Level2Screen(question: question));
    case 3:
      Get.offAll(Level3Screen(question: question));
  }
}