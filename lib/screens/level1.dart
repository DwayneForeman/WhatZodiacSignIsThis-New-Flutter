import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whatsignisthis/screens/game_over_dialog.dart';
import 'package:whatsignisthis/utils/get_image.dart';
import 'package:whatsignisthis/widgets/game_header.dart';

import '../utils/audio_services.dart';
import '../utils/get_incorrect_answer_description.dart';
import 'correct_answer_dialog.dart';
import 'incorrect_answer_dialog.dart';

class Level1Screen extends StatefulWidget {
  const Level1Screen({super.key, required this.question});
  final MapEntry<String, String> question;

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
  String selectedAnswer = "";
  String correctAnswer = '';
  List<String> allSigns = ['Aries', 'Taurus', 'Cancer', 'Gemini', 'Aquarius', 'Virgo', 'Capricorn', 'Leo', 'Libra', 'Pisces', 'Scorpio', 'Sagittarius'];
  List<String> incorrectAnswers = [];
  bool isUsed50 = false;
  final AudioService audioService = AudioService();
  List<String> correctAnsSounds = [
    'assets/sounds/correct-ans1.mpeg',
    'assets/sounds/correct-ans2.mpeg',
    'assets/sounds/correct-ans3.mpeg',
    'assets/sounds/correct-ans4.mpeg',
  ];

  List<String> incorrectAnsSounds = [
    'assets/sounds/incorrect-ans1.mpeg',
    'assets/sounds/incorrect-ans2.mpeg',
    'assets/sounds/incorrect-ans3.mpeg',
    'assets/sounds/incorrect-ans4.mpeg',
  ];

  String? randomCorrectSound;
  String? randomIncorrectSound;

  late ConfettiController _confettiController;

  late List<String> options;

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.question.key;
    allSigns.shuffle();
    allSigns.remove(correctAnswer);
    options = allSigns.take(3).toList();
    options.add(correctAnswer);
    options.shuffle();
    audioService.playSound(
        audioPath: 'assets/sounds/bg-music.mpeg', loop: true);
    correctAnsSounds.shuffle();
    randomCorrectSound = correctAnsSounds[0];
    incorrectAnsSounds.shuffle();
    randomIncorrectSound = incorrectAnsSounds[0];
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    audioService.dispose();
    super.dispose();
  }

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
                    image: AssetImage('assets/images/home-bg.png'),
                    fit: BoxFit.fill)),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      GameHeader(
                          question: widget.question.value,
                          onBalloonTap: (){
                            if (!isUsed50) {
                              audioService.playSound(
                                  audioPath:
                                  'assets/sounds/balloon-tap.mpeg');
                              getRandomIncorrectAnswers();
                              isUsed50 = true;
                            }
                          }),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          optionsContainer(
                              options[0], getImage(options[0])),
                          optionsContainer(
                              options[1], getImage(options[1])),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          optionsContainer(
                              options[2], getImage(options[2])),
                          optionsContainer(options[3], getImage(options[3])),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2, // downwards
              emissionFrequency: 1,
              numberOfParticles: 20,
              gravity: 0.5,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 10,
              minBlastForce: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget optionsContainer(String label, String imgPath) {
    final isSelected = label == selectedAnswer;
    final isExcluded = incorrectAnswers.contains(label);
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        // Disable tapping incorrect answers that are marked with the cross
        if (!isExcluded) {
          setState(() {
            selectedAnswer = label;
          });
          if (selectedAnswer == correctAnswer) {
            _confettiController.play();
            audioService.playSound(
                audioPath:
                    randomCorrectSound ?? 'assets/sounds/correct-ans1.mpeg');
            await Future.delayed(const Duration(seconds: 1));
            CorrectAnswerDialog.showResponseDialog(context, imgPath);
          } else {
            audioService.playSound(
                audioPath: randomIncorrectSound ??
                    'assets/sounds/incorrect-ans1.mpeg');
            IncorrectAnswerDialog.showResponseDialog(
                context: context,
                signImage: imgPath,
                answer: label,
                description: getIncorrectAnswerDescription(label));
          }
          audioService.playerStateStream.listen((playerState) async {
            if (playerState.processingState == ProcessingState.completed) {
              Get.back();  // Hide the current dialog
              GameOverDialog.showResponseDialog(context: context, replyLevel: 1);  // Show the Game Over dialog
            }
          });
        }
      },
      child: Container(
        width: width * 0.43,
        height: width * 0.36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? null : const Color(0x30ffffff),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xffF6D365), Color(0xffFDA085)])
                : null),
        child: isExcluded
            ? Center(
                child: Image.asset('assets/images/cross-with-bg.png',
                    width: width * 0.24,
                    height: width * 0.24)) // Show cross for incorrect answers
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imgPath,
                      width: width * 0.16, height: width * 0.16),
                  SizedBox(height: width * 0.0167),
                  isSelected
                      ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Color(0xff6A11CB), Color(0xff2575FC)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Text(label,
                              style: TextStyle(
                                  fontFamily: "SF-Compact",
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xffffffff),
                                  fontSize: width * 0.056)))
                      : Text(label,
                          style: TextStyle(
                            fontFamily: "SF-Compact",
                            fontWeight: FontWeight.w900,
                            color: const Color(0xffffffff),
                            fontSize: width * 0.056,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                          )),
                ],
              ),
      ),
    );
  }

  // Generate two random incorrect answers and store them in the incorrectAnswers list
  void getRandomIncorrectAnswers() {
    setState(() {
      incorrectAnswers.clear();
      List<String> tempOptions = List.from(options);
      tempOptions
          .remove(correctAnswer); // Remove the correct answer from the pool
      tempOptions.shuffle();
      incorrectAnswers =
          tempOptions.take(2).toList(); // Select two incorrect answers
    });
  }

}
