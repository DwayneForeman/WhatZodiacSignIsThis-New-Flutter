import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/screens/home_screen.dart';
import 'package:whatsignisthis/utils/play_games/add_score_to_leaderboard.dart';

import '../subscription/subscription_controller.dart';
import '../utils/audio_service/audio_services.dart';
import '../utils/functions/open_url.dart';
import '../utils/play_games/play_games_signin.dart';
import '../utils/variables.dart';
import 'onboarding/onboarding.dart';
import '../utils/functions/fetch_subscription_price.dart';

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
    fetchSubscriptionPrice();
  }



  Future<void> initialize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Getting show high score flag from shared preference for showing high score dialog.
    // Once dialog is shown, it is set to false, and become true again once the user reach to
    // zero and start a new game. It is saved in shared preference so that if the user close app
    // and start playing same level again, so avoid showing dialog again on same level.
    GlobalVariables.to.showHighScoreDialog.value = prefs.getBool('showHighScoreDialog') ?? true;

    // Checking if user disabled the sound or not.
    bool? soundOff = prefs.getBool('soundOff');
    GlobalVariables.to.disableSound.value = soundOff ?? false;

    // play laughing sound on start of welcome screen.
    audioService.playSound(audioPath: 'assets/sounds/laughing.mpeg');

    // signin to google play games.
    await playGamesSignin();

    // check if it is new install
    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // if its new install set the points to 100 and set the value of variable to 1 which shows
    // first three questions to user.
    if(isFirstLaunch){
      await prefs.setInt('points', 100);
      GlobalVariables.to.points.value = 100;
      isFirstLaunch = true;
      await prefs.setInt('newInstallQuestionToShow', 1);
      GlobalVariables.to.newInstallQuestionToShow.value = 1;
    }
    // If its not new install
    else {
      // check if user played first 3 questions
      GlobalVariables.to.newInstallQuestionToShow.value = prefs.getInt('newInstallQuestionToShow') ?? 0;

      // Get points from shared preference, if not present in shared preference
      // then set scores to 100.
      GlobalVariables.to.points.value = prefs.getInt('points') ?? 100;

      // Get user's score from leaderboard so check that if local high scores are updated or not
      // on leaderboard. Maybe user played offline last time, so we update the score to leader board
      // this time if local high scores are greater than leader board score of player.
      int? score = await GamesServices.getPlayerScore(androidLeaderboardID: GlobalVariables.to.androidLeaderBoardID);
      if(GlobalVariables.to.points.value > score!){
        submitScore(GlobalVariables.to.points.value);
      }
    }

    // Getting high score from leaderboard and saving it into shared preference (if not present).
    int score;
    if(await GamesServices.isSignedIn) {
      // getting score from leader board
      score = await GamesServices.getPlayerScore(androidLeaderboardID: GlobalVariables.to.androidLeaderBoardID) ?? 100;
    } else{
      // if not present in leader board then setting score to 100.
      score = 100;
    }
    // if high score instance is present in shared preference
    // set the value fo high score variable equal to that instance.
    if(prefs.containsKey('high_scores')){
      GlobalVariables.to.highScores.value = prefs.getInt('high_scores')!;
    }
    // If high score is not present in shared preference, then adding that in shared
    // preference and also setting the value of high score variable
    else {
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
                onTap: () {
                  onBtnClick();
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

  Future<void> onBtnClick() async {
    audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');

    if(isFirstLaunch) {
      await precacheImage(const AssetImage("assets/images/onboarding-carousel-bg.png"), context);
      Get.offAll(const OnboardingScreen());
    } else{
      if(subscriptionController.entitlement.value == Entitlement.premium) {
        await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
        Get.offAll(const HomeScreen());
      } else{
        await precacheImage(const AssetImage("assets/images/onboarding-carousel-bg.png"), context);
        Get.offAll(const OnboardingScreen());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioService.dispose();
  }
}
