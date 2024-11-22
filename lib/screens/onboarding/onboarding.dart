import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';

import '../../subscription/subscription_controller.dart';
import '../../utils/audio_service/audio_services.dart';
import '../../utils/functions/on_level1_start.dart';
import '../../utils/variables.dart';
import 'carousel_items/carousel1.dart';
import 'carousel_items/carousel2.dart';
import 'carousel_items/carousel3.dart';
import 'carousel_items/carousel4.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final carouselController = PageController();
  int currentIndex = 0;

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
                  CarouselItem4(),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                onNextBtnTap();
              },
              child: Container(
                width: width * 0.7,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    colors: [Color(0xffAC32E4), Color(0xff7918F2),Color(0xff4801FF)],
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
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            SmoothPageIndicator(
              controller: carouselController,
              count: 4,
              effect: const SwapEffect(
                activeDotColor: Color(0xffA679FF),
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

  Future<void> onNextBtnTap() async{
    // Button Press Sound
    audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');

    //On Click of Next on Last Carousel item
    if (carouselController.page == 3) {

      // Set first time to false
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLaunch', false);

      //User didn't play the first 3 questions and have free plan
      // So show him first upgrade screen with close icon
      // On clicking close, he'll go to the home screen
      if(GlobalVariables.to.newInstallQuestionToShow.value != 0 && subscriptionController.entitlement.value == Entitlement.free) {
        await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
        Get.offAll(const UpgradeScreen(showClose: true, goBack: false));
      }

      // User has premium subscription so send him to level 1
      else if(subscriptionController.entitlement.value == Entitlement.premium){
        await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
        onLevel1Start(context);
      }

      // User has no subscription and played first 3 questions.
      // So send him to upgrade screen with no close icon
      else {
        await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
        Get.offAll(const UpgradeScreen(showClose: false, goBack: true));
      }

      // Onboarding carousel scrolling
    } else {
      carouselController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioService.dispose();
  }
}
