import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../../screens/game_levels/level1.dart';
import 'get_new_install_jokes.dart';
import 'get_random_question.dart';

Future<void> onLevel1Start(BuildContext context) async {
  MapEntry<String, String> question;
  // If user is new and not played first 3 questions, then show first 3 questions
  // according to the index
  if(GlobalVariables.to.newInstallQuestionToShow.value != 0)
  {
    switch (GlobalVariables.to.newInstallQuestionToShow.value) {
      case 1:
        question = await getNthKeyValuePair(0);
      case 2:
        question = await getNthKeyValuePair(1);
      case 3:
        question = await getNthKeyValuePair(2);
      default:
        question = await getRandomQuestion();
    }
  }
  //
  else{
    question = await getRandomQuestion();
  }
  await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
  Get.offAll(Level1Screen(question: question));
}