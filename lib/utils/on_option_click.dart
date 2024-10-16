import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/utils/on_level1_start.dart';
import 'package:whatsignisthis/utils/points.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../screens/correct_answer_dialog.dart';
import '../screens/game_over_dialog.dart';
import '../screens/incorrect_answer_dialog.dart';
import 'audio_services.dart';
import 'get_incorrect_answer_description.dart';

Future<void> onOptionClick({required BuildContext context, required String selectedAnswer, required String correctAnswer, required ConfettiController confettiController, required String randomCorrectSound, required String randomIncorrectSound, required String imgPath, required String incorrectAnsLable}) async {
  final AudioService audioService = AudioService();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalVariables.to.newInstallQuestionToShow.value = GlobalVariables.to.newInstallQuestionToShow.value+1;
  await prefs.setInt('newInstallQuestionToShow', GlobalVariables.to.newInstallQuestionToShow.value);

  if (selectedAnswer == correctAnswer) {
    confettiController.play();
    audioService.playSound(
        audioPath: randomCorrectSound);
    await Future.delayed(const Duration(seconds: 1));
    CorrectAnswerDialog.showResponseDialog(context, imgPath);
    Points.addPoints(10);
  } else {
    audioService.playSound(
        audioPath: randomIncorrectSound);
    IncorrectAnswerDialog.showResponseDialog(
        context: context,
        signImage: imgPath,
        answer: incorrectAnsLable,
        description: getIncorrectAnswerDescription(incorrectAnsLable));
    await Points.usePoints(10);
    // if Points are zero or less, the game will be over.
    if(GlobalVariables.to.points.value <= 0) {
      GlobalVariables.to.isGameOver.value = true;
    }
  }


     // audio player state
    audioService.playerStateStream.listen((playerState) async {
      // if sound is not disabled
    if (!GlobalVariables.to.disableSound.value) {
         //if sound finished its playing
        if (playerState.processingState == ProcessingState.completed) {
          gameOverCheck(context);
        }
    }
    // if sound is disabled
    else {
      await Future.delayed(const Duration(seconds: 2));
      gameOverCheck(context);
    }
  });
  }

  Future<void> gameOverCheck(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if game is over, then show game over dialog
    if(GlobalVariables.to.isGameOver.value == true){
      Get.back(); // Hide the current dialog
      GameOverDialog.showResponseDialog(
          context: context, replyLevel: 1); // Show the Game Over dialog
      GlobalVariables.to.points.value = 100;
      prefs.setInt('points', 100);
      GlobalVariables.to.isGameOver.value = false;
    }
    // if game is not over then show next question
    else {
      Get.back();
      Get.back();
      onLevel1Start(context);
    }
  }