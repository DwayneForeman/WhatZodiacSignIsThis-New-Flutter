import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsignisthis/widgets/gradient_button.dart';

import '../utils/audio_services.dart';
import '../utils/open_url.dart';

class HighScoreDialog {
  static bool isDialogShown = false;

  HighScoreDialog();
  final AudioService audioService = AudioService();

  static void showResponseDialog(BuildContext context) {
    final AudioService audioService = AudioService();
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context, // Use the passed context
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: IntrinsicHeight(
              child: Container(
                width: width * 0.9,
                padding:
                const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/how-to-play-bg.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                      Image.asset('assets/images/high-score-icon.png',
                          width: 95, height: 95),
                          GestureDetector(
                            onTap: (){
                              audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                              Get.back();
                            },
                            child: Image.asset('assets/images/close-icon.png',
                            color: Colors.white,
                            width: 20, height: 20),
                          ),
                    ]),
                    const SizedBox(height: 10),
                    Image.asset('assets/images/high-score-text.png', width: width*0.55),
                    const SizedBox(height: 30),
                    const Text('You’ve made it to the charts!\nCongrats on your new score. See how you rank amongst your peers.',
                    textAlign: TextAlign.center, style: TextStyle(fontFamily: 'SF-Pro', color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)
                    ),
                    const SizedBox(height: 36),
                    GradientButton(
                        onTap: (){
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                          openUrl(link: 'https://apps.apple.com/us/app/what-zodiac-sign-is-this-quiz/id6468937334');
                        },
                        text: 'RATE US',
                        width: width * 0.64,
                        height: 70,
                        btnClrs: const [Color(0xffB3FFAB), Color(0xff12FFF7)],
                        txtClr: Colors.black),
                    const SizedBox(height: 12),
                    GradientButton(
                        onTap: (){
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                        },
                        text: 'VIEW RANKINGS',
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
                  ],
                ),
              ),
            ));
      },
    );
  }
}
