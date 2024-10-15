import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/audio_services.dart';
import '../utils/get_image.dart';
import '../widgets/game_header.dart';
import 'correct_answer_dialog.dart';
import 'game_over_dialog.dart';
import 'incorrect_answer_dialog.dart';

class Level3Screen extends StatefulWidget {
  const Level3Screen({super.key, required this.question});
  final MapEntry<String, String> question;

  @override
  State<Level3Screen> createState() => _Level3ScreenState();
}

class _Level3ScreenState extends State<Level3Screen> {

  String selectedAnswer = "";
  String correctAnswer = "Capricorn";
  List<String> options = ['Aries', 'Taurus', 'Cancer', 'Gemini', 'Aquarius', 'Virgo', 'Capricorn', 'Leo', 'Libra', 'Pisces', 'Scorpio', 'Sagittarius'];
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

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.question.key;
    options.shuffle();
    audioService.playSound(audioPath: 'assets/sounds/bg-music.mpeg', loop: true);
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
                    fit: BoxFit.fill
                )
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(
                              options[0], getImage(options[0])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[1], getImage(options[1])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[2], getImage(options[2])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[3], getImage(options[3])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(
                              options[4], getImage(options[4])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[5], getImage(options[5])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[6], getImage(options[6])),
                          const SizedBox(width: 8),
                          optionsContainer(
                              options[7], getImage(options[7])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(
                              options[8], getImage(options[8])),
                          const SizedBox(width: 10),
                          optionsContainer(
                              options[9], getImage(options[9])),
                          const SizedBox(width: 10),
                          optionsContainer(
                              options[10], getImage(options[10])),
                          const SizedBox(width: 10),
                          optionsContainer(
                              options[11], getImage(options[11])),
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

  // Generate two random incorrect answers and store them in the incorrectAnswers list
  void getRandomIncorrectAnswers() {
    setState(() {
      incorrectAnswers.clear();
      List<String> tempOptions = List.from(options);
      tempOptions.remove(correctAnswer); // Remove the correct answer from the pool
      tempOptions.shuffle();
      incorrectAnswers = tempOptions.take(6).toList(); // Select two incorrect answers
    });
  }

  String getIncorrectDescription(String answer) {
    switch (answer.toLowerCase()) {
      case 'aries':
        return 'Dismissive\nEasily Angered\nRash';
      case 'aquarius':
        return 'Impatient\nStubborn\nCaring';
      case 'cancer':
        return 'Moody\nAfraid to Blossom\nUnable to Let Go';
      case 'capricorn':
        return 'Self-Righteous\nJudgmental\nCold';
      case 'gemini':
        return 'Repetitive\nLiars\nPoor Listeners';
      case 'leo':
        return 'Egotistic\nVain\nDramatic';
      case 'libra':
        return 'Indecisive\nConflict-Avoidant\nEasily Distracted';
      case 'pisces':
        return 'Impractical\nTakes on Others Issues\nProjects Guilt';
      case 'sagittarius':
        return 'Too Energetic\nUnpredictable\nLoud';
      case 'scorpio':
        return 'Manipulative\nHostile\nVengeful';
      case 'taurus':
        return 'Cautious\nAntisocial\nLazy';
      case 'virgo':
        return 'Knit-Picky\nDetail-Oriented\nSloppy';
      default:
        return 'Impatient\nStubborn\nCaring';
    }
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
          if(selectedAnswer == correctAnswer){
            _confettiController.play();
            audioService.playSound(audioPath: randomCorrectSound ?? 'assets/sounds/correct-ans1.mpeg');
            await Future.delayed(const Duration(seconds: 1));
            CorrectAnswerDialog.showResponseDialog(context, imgPath);
          } else{
            audioService.playSound(audioPath: randomIncorrectSound ?? 'assets/sounds/incorrect-ans1.mpeg');
            IncorrectAnswerDialog.showResponseDialog(context: context, signImage: imgPath, answer: label, description: getIncorrectDescription(label));
          }
          audioService.playerStateStream.listen((playerState) async {
            if (playerState.processingState == ProcessingState.completed) {
              Get.back();  // Hide the current dialog
              GameOverDialog.showResponseDialog(context: context, replyLevel: 3);  // Show the Game Over dialog
            }
          });
        }
      },
      child: Container(
        width: width * 0.2,
        height: width * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelected ? null : const Color(0x30ffffff),
            gradient: isSelected
                ? const LinearGradient(
                colors: [Color(0xffF6D365), Color(0xffFDA085)])
                : null),
        child: isExcluded
            ? Center(child: Image.asset('assets/images/cross-with-bg.png', width: width * 0.16, height: width * 0.16)) // Show cross for incorrect answers
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath,
                width: width * 0.095, height: width * 0.095),
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
                        fontSize: width * 0.028)))
                : Text(label,
                style: TextStyle(
                    fontFamily: "SF-Compact",
                    fontWeight: FontWeight.w900,
                    color: const Color(0xffffffff),
                    fontSize: width * 0.032)),
          ],
        ),
      ),
    );
  }
}
