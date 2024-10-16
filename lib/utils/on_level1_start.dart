import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../screens/level1.dart';
import 'get_new_install_jokes.dart';
import 'get_random_question.dart';

Future<void> onLevel1Start(BuildContext context) async {
  precacheImage(const AssetImage("assets/images/home-bg.png"), context);
  MapEntry<String, String> question;
  switch(GlobalVariables.to.newInstallQuestionToShow.value){
    case 1:
      question = await getNthKeyValuePair(0);
    case 2:
      question = await getNthKeyValuePair(1);
    case 3:
      question = await getNthKeyValuePair(2);
    default:
      question = await getRandomQuestion();
  }
  Get.to(Level1Screen(question: question));
}