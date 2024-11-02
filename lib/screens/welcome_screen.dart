import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';
import 'package:whatsignisthis/utils/on_level1_start.dart';

import '../subscription/subscription_controller.dart';
import '../utils/audio_services.dart';
import '../utils/open_url.dart';
import '../utils/play_games_signin.dart';
import '../utils/variables.dart';
import 'onboarding.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late bool isFirstLaunch;

  final AudioService audioService = AudioService();
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Future<void> fetchPrices() async {
  //   final offerings = await PurchaseApi.fetchOffers();
  //
  //   if (offerings.isEmpty) {
  //     debugPrint('Error Fetching Prices');
  //   } else {
  //     final packages = offerings
  //         .map((offer) => offer.availablePackages)
  //         .expand((pair) => pair)
  //         .toList();
  //    //print(packages[0].storeProduct);
  //   }
  // }



  Future<void> initialize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? soundOff = prefs.getBool('soundOff');
    GlobalVariables.to.disableSound.value = soundOff ?? false;
    audioService.playSound(audioPath: 'assets/sounds/laughing.mpeg');
    playGamesSignin();
    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if(isFirstLaunch){
      await prefs.setInt('points', 100);
      GlobalVariables.to.points.value = 100;
      isFirstLaunch = true;
      await prefs.setInt('newInstallQuestionToShow', 1);
      GlobalVariables.to.newInstallQuestionToShow.value = 1;
    } else {
      GlobalVariables.to.newInstallQuestionToShow.value = prefs.getInt('newInstallQuestionToShow') ?? 0;
      GlobalVariables.to.points.value = prefs.getInt('points') ?? 100;
    }

    //High Score
    int score;
    if(await GamesServices.isSignedIn) {
      score = await GamesServices.getPlayerScore(androidLeaderboardID: 'CgkImMyHs-MNEAIQAQ') ?? 100;
    } else{
      score = 100;
    }
    if(prefs.containsKey('high_scores')){
      GlobalVariables.to.highScores.value = prefs.getInt('high_scores')!;
    } else {
      prefs.setInt("high_scores", score);
      GlobalVariables.to.highScores.value = score;
      debugPrint(GlobalVariables.to.highScores.value.toString());
    }

  }

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
                image: AssetImage("assets/images/onboarding-bg.png"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset("assets/images/onboarding-logo.png",
                  width: width * 0.9,
                  height: width * 0.9),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                  if(isFirstLaunch) {
                    await precacheImage(const AssetImage("assets/images/onboarding-carousel-bg.png"), context);
                    Get.offAll(const OnboardingScreen());
                  } else{
                    await SubscriptionController().refreshCustomerInfo();
                    debugPrint(subscriptionController.entitlement.value.toString());
                    if(GlobalVariables.to.newInstallQuestionToShow.value != 0 || subscriptionController.entitlement.value == Entitlement.premium) {
                      onLevel1Start(context);
                    } else {
                      await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                      Get.offAll(const UpgradeScreen(showClose: false, goBack: true));
                    }
                  }
                },
                child: Container(
                  width: width * 0.75,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [Color(0xff6814CE), Color(0xff296FF9)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/letsplay-text.png', height: 40),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      height: 1.5,
                      fontFamily: "Mont",
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                      fontSize: 10,
                    ),
                    children: [
                      const TextSpan(
                        text: 'By tapping "Let\'s Play" you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Service.',
                        style: const TextStyle(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                            openUrl(link: 'https://www.whatzodiacsignisthis.com/terms');
                          },
                      ),
                      const TextSpan(text: ' Learn how we protect your data in our '),
                      const TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
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
