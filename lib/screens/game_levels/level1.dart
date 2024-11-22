import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:whatsignisthis/utils/functions/get_image_according_to_sign.dart';
import 'package:whatsignisthis/widgets/game_level_screen_header.dart';

import '../../utils/audio_service/audio_services.dart';
import '../../utils/functions/get_new_install_jokes.dart';
import '../../utils/functions/get_random_question.dart';
import '../../utils/functions/on_option_click.dart';
import '../../utils/functions/points_service.dart';
import '../../utils/variables.dart';

class Level1Screen extends StatefulWidget {
  const Level1Screen({super.key, required this.question});

  final MapEntry<String, String> question;

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
  String selectedAnswer = "";
  String correctAnswer = '';
  String question = '';
  List<String> incorrectAnswers = [];
  bool isUsed50 = false;
  List<String> allSigns = List.from(GlobalVariables.allSigns);

  String? randomCorrectSound;
  String? randomIncorrectSound;

  late ConfettiController _confettiController;

  late List<String> options;
  final AudioService audioService = AudioService();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    correctAnswer = widget.question.key;
    question = widget.question.value;
    allSigns.remove(correctAnswer);
    options = allSigns.take(3).toList();
    options.add(correctAnswer);
    options.shuffle();
    audioService.playSound(
        audioPath: 'assets/sounds/bg-music.mpeg', loop: true);
    List<String> correctSounds = List.from(GlobalVariables.correctAnsSounds);
    correctSounds.shuffle();
    randomCorrectSound = correctSounds[0];
    List<String> incorrectSounds =
        List.from(GlobalVariables.incorrectAnsSounds);
    incorrectSounds.shuffle();
    randomIncorrectSound = incorrectSounds[0];
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
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
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      GameHeader(
                          audioService: audioService,
                          question: question,
                          onBalloonTap: () {
                            if (!isUsed50 &&
                                GlobalVariables.to.points.value >= 5) {
                               audioService.playSound(
                                  audioPath: 'assets/sounds/balloon-tap.mpeg');
                              getRandomIncorrectAnswers();
                              isUsed50 = true;
                              Points.usePoints(5);
                            }
                          }),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          optionsContainer(options[0], getImage(options[0])),
                          optionsContainer(options[1], getImage(options[1])),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          optionsContainer(options[2], getImage(options[2])),
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
              blastDirection: 3.14 / 2,
              // downwards
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
          audioService.stopSound();
          await onOptionClick(
              audioService: audioService,
              level: 1,
              context: context,
              confettiController: _confettiController,
              correctAnswer: correctAnswer,
              imgPath: imgPath,
              incorrectAnsLabel: label,
              randomCorrectSound:
                  randomCorrectSound ?? 'assets/sounds/correct-ans1.mpeg',
              randomIncorrectSound:
                  randomIncorrectSound ?? 'assets/sounds/incorrect-ans1.mpeg',
              selectedAnswer: selectedAnswer);
          if(GlobalVariables.to.showNextQuestion.value == true){
            showNextQuestion();
          }
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

  Future<void> showNextQuestion() async {
    MapEntry<String, String> randomQuestion;
      if(GlobalVariables.to.newInstallQuestionToShow.value == 2) {
        randomQuestion = await getNthKeyValuePair(1);
      } else if(GlobalVariables.to.newInstallQuestionToShow.value == 3){
        randomQuestion = await getNthKeyValuePair(2);
      } else {
        randomQuestion = await getRandomQuestion();
      }
      print(GlobalVariables.to.newInstallQuestionToShow.value);
    setState(() {
      correctAnswer = randomQuestion.key;
      question = randomQuestion.value;
      selectedAnswer = '';
      incorrectAnswers = [];
      isUsed50 = false;
      allSigns = List.from(GlobalVariables.allSigns);
      allSigns.remove(correctAnswer);
      options = allSigns.take(3).toList();
      options.add(correctAnswer);
      options.shuffle();
      List<String> correctSounds = List.from(GlobalVariables.correctAnsSounds);
      correctSounds.shuffle();
      randomCorrectSound = correctSounds[0];
      List<String> incorrectSounds =
      List.from(GlobalVariables.incorrectAnsSounds);
      incorrectSounds.shuffle();
      randomIncorrectSound = incorrectSounds[0];
    });
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