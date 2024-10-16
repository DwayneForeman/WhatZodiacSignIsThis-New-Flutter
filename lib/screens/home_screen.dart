import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/screens/high_score_dialog.dart';
import 'package:whatsignisthis/screens/level1.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../utils/audio_services.dart';
import '../utils/get_new_install_jokes.dart';
import '../utils/get_random_question.dart';
import '../utils/on_level1_start.dart';
import 'level2.dart';
import 'level3.dart';
import 'menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home-bg.png"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                GlobalVariables.to.disableSound.value = !GlobalVariables.to.disableSound.value;
                                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('soundOff', GlobalVariables.to.disableSound.value);
                              },
                              child: Obx(() => Image.asset(
                                GlobalVariables.to.disableSound.value
                                    ? 'assets/images/sound-off.png'
                                    : 'assets/images/sound-on.png',
                                height: width*0.07,
                                width: width*0.07,
                              ))),
                          const SizedBox(height: 20),
                          Text("Home",
                              style: TextStyle(
                                  fontFamily: "SF-Compact",
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xffffffff),
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.08))
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: (){
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                          HighScoreDialog.showResponseDialog(context);
                        },
                        child: Image.asset('assets/images/stats-icon.png', width: width*0.12, height: width*0.12)),
                    const SizedBox(width: 12),
                    GestureDetector(
                        onTap: (){
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                          openMenuBottomSheet(context);
                        },
                        child: Image.asset('assets/images/menu-icon.png', width: width*0.1111, height: width*0.1111)),
                  ],
                ),
                const SizedBox(height: 30),
                Image.asset("assets/images/home-emoji.png",
                    width: width * 0.17,
                    height: width * 0.17),
                const SizedBox(height: 16),
                Image.asset('assets/images/letsplay-text.png', width: width*0.5),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                         audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                         onLevel1Start(context);
                        },
                        child: Image.asset('assets/images/Level1-home.png', width: width*0.43)),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () async {
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                          precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                          MapEntry<String, String> question = await getRandomQuestion();
                          Get.to(Level2Screen(question: question));
                        },
                        child: Image.asset('assets/images/level2-home.png', width: width*0.43)),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () async {
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                      MapEntry<String, String> question = await getRandomQuestion();
                      Get.to(Level3Screen(question: question));
                    },
                    child: Image.asset('assets/images/level3-home.png', width: width*0.9)),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioService.dispose();
  }

}
