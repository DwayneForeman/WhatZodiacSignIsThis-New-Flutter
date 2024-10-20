import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whatsignisthis/screens/carousel_items/carousel3.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';

import '../utils/audio_services.dart';
import 'carousel_items/carousel1.dart';
import 'carousel_items/carousel2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final carouselController = PageController();
  int currentIndex = 0;

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/onboarding-carousel-bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: height - 170,
              child: PageView(
                dragStartBehavior: DragStartBehavior.down,
                controller: carouselController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: const [
                  CarouselItem1(),
                  CarouselItem2(),
                  CarouselItem3(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                if (carouselController.page == 2) {
                  await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                  Get.offAll(const UpgradeScreen());
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isFirstLaunch', false);
                } else {
                  carouselController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                width: width * 0.7,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    colors: [Color(0xff84FAB0), Color(0xff005BEA)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontFamily: "SF-Compact",
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            SmoothPageIndicator(
              controller: carouselController,
              count: 3,
              effect: const SwapEffect(
                activeDotColor: Color(0xffffffff),
                dotColor: Color(0xff828282),
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
              ),
            ),
            const Spacer(),
          ],
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
