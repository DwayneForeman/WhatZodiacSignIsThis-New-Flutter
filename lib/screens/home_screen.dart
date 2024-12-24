import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';
import 'package:whatsignisthis/utils/audio_service/disable_sound.dart';
import 'package:whatsignisthis/utils/game_play_functions/start_level.dart';
import 'package:whatsignisthis/utils/variables.dart';

import '../subscription/subscription_controller.dart';
import '../utils/audio_service/audio_services.dart';
import '../utils/game_play_functions/on_level1_start.dart';
import '../utils/leader_board/show_leaderboard.dart';
import 'horoscope_screen.dart';
import 'shop_web_view.dart';
import 'menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeController homeController = Get.put(HomeController());
  final AudioService audioService = AudioService();
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                                    audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
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
                              audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
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
                              audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
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
                             audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                             onLevel1Start(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Image.asset('assets/images/Level1-home.png', width: width*0.43),
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () async {
                              audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                              if(subscriptionController.entitlement.value == Entitlement.premium) {
                                await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                                startLevel(2);
                              } else {
                                await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                                Get.to(const UpgradeScreen(goBack: true, showClose: true));
                              }
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Image.asset('assets/images/level2-home.png', width: width*0.43),
                                ),
                                Visibility(
                                  visible: subscriptionController.entitlement.value == Entitlement.free,
                                  child: Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Center(child: Image.asset('assets/images/lock-with-circle.png', width: 40))),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                        onTap: () async {
                          audioService.playSound(audioPath: 'assets/sounds/button-press.mp3');
                          if(subscriptionController.entitlement.value == Entitlement.premium) {
                            await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                            startLevel(3);
                          } else {
                            await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                            Get.to(const UpgradeScreen(showClose: true, goBack: true,));
                          }
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Image.asset('assets/images/level3-home.png', width: width*0.9),
                            ),
                            Visibility(
                              visible: subscriptionController.entitlement.value == Entitlement.free,
                              child: Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Center(child: Image.asset('assets/images/lock-with-circle.png', width: 40))),
                            ),
                          ],
                        )),
                    const Spacer(flex: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/game-icon.png', width: 25),
                              const Text('Game', style: TextStyle(fontFamily: 'SF-Compact', color: Color(0xff84FAB0), fontWeight: FontWeight.w900, fontSize: 14))
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Get.to(const HoroscopeScreen()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/horoscope-icon.png', width: 26),
                                const Text('Horoscope', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(() => const WebViewScreen(url: 'https:whatsignisthis.store'));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/shop-icon.png', width: 20),
                                const Text('Shop', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
            visible: homeController.isLoading.value,
            child: Container(
              width: width,
              height: height,
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioService.dispose();
  }

}

class HomeController extends GetxController {
  var isLoading = false.obs;
}
