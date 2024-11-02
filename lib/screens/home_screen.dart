import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';
import 'package:whatsignisthis/utils/disable_sound.dart';
import 'package:whatsignisthis/utils/start_level.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../subscription/subscription_controller.dart';
import '../utils/audio_services.dart';
import '../utils/on_level1_start.dart';
import '../utils/show_leaderboard.dart';
import 'menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AudioService audioService = AudioService();
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

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
                                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                disableSound();
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
                        onTap: () async {
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                          if(await GamesServices.isSignedIn) {
                            showLeaderboard();
                          } else {
                            await GamesServices.signIn();
                            showLeaderboard();
                          }
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
                          if(subscriptionController.entitlement.value == Entitlement.premium) {
                            await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                            startLevel(2);
                          } else {
                            await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                            Get.to(const UpgradeScreen(goBack: true, showClose: true));
                          }
                        },
                        child: Image.asset('assets/images/level2-home.png', width: width*0.43)),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () async {
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      if(subscriptionController.entitlement.value == Entitlement.premium) {
                        await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                        startLevel(3);
                      } else {
                        await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                        Get.to(const UpgradeScreen(showClose: true, goBack: true,));
                      }
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
