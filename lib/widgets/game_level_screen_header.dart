import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/home_screen.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../utils/audio_service/audio_services.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.question, required this.onBalloonTap, required this.audioService});
  final String question;
  final VoidCallback onBalloonTap;
  final AudioService audioService;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, FormData? result) async {
            Get.offAll(const HomeScreen());
            return;
          },
          child: SizedBox(
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
                          child: Obx(() => Text(GlobalVariables.to.points.value.toString(),
                              style: TextStyle(
                                  fontFamily: "SF-Compact",
                                  fontWeight: FontWeight.w900,
                                  fontSize: width * 0.0333,
                                  color: const Color(0xffFF0909))
                          ))
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        await audioService.playSound(
                            audioPath: 'assets/sounds/button-press.mp3');
                        audioService.stopSound();
                        await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                        Get.offAll(const HomeScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Image.asset('assets/images/home-button.png',
                            width: width * 0.1638),
                      ))
                ],
              )
          ),
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
