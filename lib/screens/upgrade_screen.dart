import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/level1.dart';
import 'package:whatsignisthis/utils/open_url.dart';

import '../utils/audio_services.dart';
import '../utils/get_random_question.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, FormData? result) async {
          MapEntry<String, String> question = await getRandomQuestion();
          await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
          Get.offAll(Level1Screen(question: question));
          return;
        },
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/how-to-play-bg.png"),
                  fit: BoxFit.fill)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: width*0.12),
                        Image.asset("assets/images/logo.png",
                            width: width * 0.48,
                            height: width * 0.48),
                        GestureDetector(
                          onTap: () async {
                            audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                            MapEntry<String, String> question = await getRandomQuestion();
                            precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                            Get.offAll(Level1Screen(question: question));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Icon(Icons.close,
                                color: Colors.white,
                                size: width * 0.07),
                          ),
                        ),
                      ],
                    ),
                    // Text("Go Premium",
                    //     style: TextStyle(
                    //         color: const Color(0xffffffff),
                    //         fontSize: width * 0.08,
                    //         fontFamily: "Cherry")),
                    // const SizedBox(height: 5),
                    // Container(
                    //   width: width * 0.65,
                    //   height: 4,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       gradient: const LinearGradient(
                    //           colors: [Color(0xffB3FFAB), Color(0xff12FFF7)])),
                    // ),
                    // const SizedBox(height: 20),
                    // FeaturesRow(
                    //     iconSize: width*0.048,
                    //     label: "3 Day Free Trial",
                    //     iconPath: "assets/images/3-day-free-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.062,
                    //     label: "Unlimited Games",
                    //     iconPath: "assets/images/unlimited-games-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.05,
                    //     label: "No More Ads",
                    //     iconPath: "assets/images/no-ads-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.058,
                    //     label: "Joke Notifications",
                    //     iconPath: "assets/images/joke-notification-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.038,
                    //     label: "Unlock All Levels",
                    //     iconPath: "assets/images/unlock-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.048,
                    //     label: "1200 + Text Meme",
                    //     iconPath: "assets/images/laughing-emoji.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.046,
                    //     label: "Free Content Updates",
                    //     iconPath: "assets/images/free-content-icon.png"),
                    // FeaturesRow(
                    //     iconSize: width*0.05,
                    //     label: "Cancel Anytime",
                    //     iconPath: "assets/images/cancel-anytime-icon.png"),
                    Image.asset('assets/images/go-premium.png', width: width*0.8),
                    const SizedBox(height: 28),
                    Text('First 3 Days For Free', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w900, fontSize: width*0.0416)),
                    Text('Then \$4.99 / week', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.03888)),
                    Text('Billing starts after trial.', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.02777)),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: (){
                        audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      },
                      child: Container(
                        width: width*0.8,
                        height: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                              colors: [Color(0xffB3FFAB), Color(0xff12FFF7)]
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Start Free Trial  ', style: TextStyle(fontFamily: 'SF-Compact', fontWeight: FontWeight.w800, fontSize: width*0.05, color: Colors.black)),
                            Image.asset('assets/images/home-emoji.png', width: width*0.0555, height: width*0.0555),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width*0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                              },
                              child: Text('Privacy', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                          GestureDetector(
                              onTap: (){
                                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                openUrl(link: 'https://www.WhatZodiacSignIsThis.com/terms');
                              },
                              child: Text('Terms', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                          GestureDetector(
                              onTap: (){
                                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                              },
                              child: Text('Restore', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
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

class FeaturesRow extends StatelessWidget {
  const FeaturesRow({super.key, required this.label, required this.iconPath, required this.iconSize});

  final String iconPath;
  final String label;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 6, left: width*0.1),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: EdgeInsets.only(left: width*0.12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: Image.asset(iconPath,
                      width: iconSize,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              Text(label,
                  style: TextStyle(
                      fontFamily: "SF-Compact",
                      fontWeight: FontWeight.w900,
                      color: const Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width * 0.038))
            ],
          ),
        ),
      ),
    );
  }
}