import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/audio_services.dart';
import '../utils/open_url.dart';
import 'home_screen.dart';
import 'onboarding.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AudioService audioService = AudioService();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? soundOff = prefs.getBool('soundOff');
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    disableSound = soundOff ?? false;
    audioService.playSound(audioPath: 'assets/sounds/laughing.mpeg');
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
                  audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                  precacheImage(const AssetImage("assets/images/onboarding-carousel-bg.png"), context);
                  Get.offAll(const OnboardingScreen());
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
                      fontFamily: "Mont",
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                      fontSize: 11,
                    ),
                    children: [
                      const TextSpan(
                        text: 'By signing up you agree to our ',
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
