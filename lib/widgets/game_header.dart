import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/audio_services.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.question, required this.onBalloonTap});
  final String question;
  final VoidCallback onBalloonTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final AudioService audioService = AudioService();
    return Column(
      children: [
        SizedBox(
            height: width*0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: onBalloonTap,
                    child: Image.asset('assets/images/balloon.png',
                        width: width * 0.2)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: width * 0.1666,
                    height: width * 0.1666,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.fill)),
                    child: Center(
                        child: Text('100',
                            style: TextStyle(
                                fontFamily: "SF-Compact",
                                fontWeight: FontWeight.w900,
                                fontSize: width * 0.0333,
                                color: const Color(0xffFF0909)))),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      await audioService.playSound(
                          audioPath: 'assets/sounds/button-press.mpeg');
                      audioService.stopSound();
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Image.asset('assets/images/home-button.png',
                          width: width * 0.1638),
                    ))
              ],
            )
        ),
        Image.asset("assets/images/bend-text.png", width: width),
        const SizedBox(height: 10),
        Container(
          width: width,
          constraints: BoxConstraints(minHeight: width * 0.64),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/text-bg.png'),
                  fit: BoxFit.fill)),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.0555,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xff210FF5),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset('assets/images/laugh-emoji.png',
                        width: width * 0.105)
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
