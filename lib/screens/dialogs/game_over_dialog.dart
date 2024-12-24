import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsignisthis/screens/home_screen.dart';
import 'package:whatsignisthis/screens/game_levels/level1.dart';
import 'package:whatsignisthis/utils/variables.dart';
import 'package:whatsignisthis/widgets/gradient_button.dart';

import '../../utils/audio_service/audio_services.dart';
import '../../utils/game_play_functions/get_random_question.dart';
import '../../utils/functions/open_url.dart';
import '../game_levels/level2.dart';
import '../game_levels/level3.dart';

class GameOverDialog {
  static bool isDialogShown = false;

  GameOverDialog();

  static void showResponseDialog({required BuildContext context, required int replyLevel, required AudioService audioService}) {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, FormData? result) async {
                Get.offAll(const HomeScreen());
                return;
              },
              child: IntrinsicHeight(
                child: Container(
                  width: width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/how-to-play-bg.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Image.asset('assets/images/home-emoji.png',
                          width: 72, height: 72),
                      const SizedBox(height: 10),
                      Image.asset('assets/images/gameover-text.png'),
                      const SizedBox(height: 30),
                      GradientButton(
                          onTap: () async {
                            audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                            GlobalVariables.to.showNextQuestion.value = true;
                            MapEntry<String, String> question = await getRandomQuestion();
                            switch(replyLevel){
                              case 1:
                                Get.offAll(Level1Screen(question: question,));
                              case 2:
                                Get.offAll(Level2Screen(question: question));
                              case 3:
                                Get.offAll(Level3Screen(question: question));
                            }
                          },
                          text: 'PLAY AGAIN',
                          width: width * 0.64,
                          height: 70,
                          btnClrs: const [Color(0xffB3FFAB), Color(0xff12FFF7)],
                          txtClr: Colors.black),
                      const SizedBox(height: 12),
                      GradientButton(
                          onTap: (){
                            audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                            Share.share('LMFAO! This app is JOKES! https://apps.apple.com/us/app/what-zodiac-sign-is-this-quiz/id6468937334');
                          },
                          text: 'SHARE W/FRIENDS',
                          fontSize: 18,
                          width: width * 0.64,
                          height: 70,
                          btnClrs: const [
                            Color(0xffFDFBFB),
                            Color(0xffEBEDEE)
                          ],
                          textGradient: const [
                            Color(0xff6A11CB),
                            Color(0xff2575FC)
                          ]),
                      const SizedBox(height: 12),
                      GradientButton(
                          onTap: (){
                            audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                            openUrl(link: 'https://apps.apple.com/us/app/what-zodiac-sign-is-this-quiz/id6468937334');
                          },
                          text: 'RATE US',
                          fontSize: 18,
                          width: width * 0.64,
                          height: 70,
                          btnClrs: const [
                            Color(0xffF6D365),
                            Color(0xffFDA085)
                          ],
                          textGradient: const [
                            Color(0xff6A11CB),
                            Color(0xff2575FC)
                          ]),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
