import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';
import 'package:whatsignisthis/utils/points.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../screens/correct_answer_dialog.dart';
import '../screens/game_over_dialog.dart';
import '../screens/incorrect_answer_dialog.dart';
import 'audio_services.dart';
import 'get_incorrect_answer_description.dart';

Future<void> onOptionClick({required BuildContext context, required String selectedAnswer, required String correctAnswer, required ConfettiController confettiController, required String randomCorrectSound, required String randomIncorrectSound, required String imgPath, required String incorrectAnsLabel, required int level, required AudioService audioService}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //Increment in the value for the new user First three questions.
  //If its 0 it means first 3 questions are already shown so no need of increment.
  if(GlobalVariables.to.newInstallQuestionToShow.value != 0 && level == 1)
  {
    GlobalVariables.to.newInstallQuestionToShow.value =
        GlobalVariables.to.newInstallQuestionToShow.value + 1;
    await prefs.setInt('newInstallQuestionToShow',
        GlobalVariables.to.newInstallQuestionToShow.value);
  }



  //If user click on the correct answer
  if (selectedAnswer == correctAnswer) {
    confettiController.play(); //play confetti if the answer is correct
    audioService.playSound(
        audioPath: randomCorrectSound); //play random sound effect
    await Future.delayed(const Duration(seconds: 1));
    CorrectAnswerDialog.showResponseDialog(context, imgPath); //Show correct answers dialog
    Points.addPoints(10); // Add 10 points
  }
  // User click the wrong answer
  else {
    audioService.playSound(
        audioPath: randomIncorrectSound); //play random sound effect for incorrect answer
    IncorrectAnswerDialog.showResponseDialog(
        context: context,
        signImage: imgPath,
        answer: incorrectAnsLabel,
        description: getIncorrectAnswerDescription(incorrectAnsLabel)); //Show incorrect answer dialog
    await Points.usePoints(10); // decrease 10 points

    // if Points are zero or less, the game will be over.
    if(GlobalVariables.to.points.value <= 0) {
      GlobalVariables.to.isGameOver.value = true;
    }
  }

  //After showing correct or incorrect answer dialog, first we check if the sound
  // is enabled or disabled. If sound is enabled, then we show the next question
  // when sound effect played completely. But if user disabled the sound, then we
  // show next question after 2 seconds.

     // Checking audio player state
    audioService.playerStateStream.listen((playerState) async {
      // if sound is not disabled
    if (!GlobalVariables.to.disableSound.value) {
         //if sound finished its playing
        if (playerState.processingState == ProcessingState.completed) {
          await gameOverCheck(context, level);
          audioService.playSound(
              audioPath: 'assets/sounds/bg-music.mpeg', loop: true);
        }
    }
    // if sound is disabled
    else {
      await Future.delayed(const Duration(seconds: 2));
      gameOverCheck(context, level);
    }
  });
  }

  // This function will check if the game is over or not. If game is over, then it will
 // show game over dialog, otherwise it will show next random question.
  Future<void> gameOverCheck(BuildContext context, int level) async {
    final AudioService audioService = AudioService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if game is over, then show game over dialog
    if(GlobalVariables.to.isGameOver.value == true){
      Get.back(); // Hide the current dialog
      //await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
      GameOverDialog.showResponseDialog(
        audioService: audioService,
          context: context, replyLevel: level); // Show the Game Over dialog
      //if game is over, revert points back to 100
      GlobalVariables.to.points.value = 100;
      await prefs.setInt('points', 100);
      //make the value of game over to false, so it should not show the game over dialog
      //for next game play
      await Future.delayed(const Duration(seconds: 1));
      GlobalVariables.to.isGameOver.value = false;
      GlobalVariables.to.showNextQuestion.value = false;
    }
    // if game is not over then show next question
    else {
      // if user is new, and he answered first 3 new user questions, then he'll
      // be redirected to upgrade screen.
      if(GlobalVariables.to.newInstallQuestionToShow.value > 3){
        Get.back();
        Get.offAll(const UpgradeScreen());
        // make new questions to show to zero so it should show random questions
        // instead of first 3 new user questions.
        GlobalVariables.to.newInstallQuestionToShow.value = 0;
        await prefs.setInt('newInstallQuestionToShow', 0);
      } else {
        //hide dialog
        Get.back();
    }
    }
  }