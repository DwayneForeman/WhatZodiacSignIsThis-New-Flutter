import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../utils/audio_service/audio_services.dart';
import '../../utils/game_play_functions/get_image_according_to_sign.dart';
import '../../utils/game_play_functions/get_random_question.dart';
import '../../utils/game_play_functions/on_option_click.dart';
import '../../utils/game_play_functions/points_service.dart';
import '../../utils/variables.dart';
import '../../widgets/game_level_screen_header.dart';

class Level3Screen extends StatefulWidget {
  const Level3Screen({super.key, required this.question});

  final MapEntry<String, String> question;

  @override
  State<Level3Screen> createState() => _Level3ScreenState();
}

class _Level3ScreenState extends State<Level3Screen> {
  String selectedAnswer = "";
  String correctAnswer = "";
  String question = '';
  List<String> allSigns = List.from(GlobalVariables.allSigns);
  List<String> incorrectAnswers = [];
  bool isUsed50 = false;

  String? randomCorrectSound;
  String? randomIncorrectSound;
  late ConfettiController _confettiController;

  final AudioService audioService = AudioService();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    correctAnswer = widget.question.key;
    question = widget.question.value;
    allSigns.shuffle();
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(allSigns[0], getImage(allSigns[0])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[1], getImage(allSigns[1])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[2], getImage(allSigns[2])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[3], getImage(allSigns[3])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(allSigns[4], getImage(allSigns[4])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[5], getImage(allSigns[5])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[6], getImage(allSigns[6])),
                          const SizedBox(width: 8),
                          optionsContainer(allSigns[7], getImage(allSigns[7])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          optionsContainer(allSigns[8], getImage(allSigns[8])),
                          const SizedBox(width: 10),
                          optionsContainer(allSigns[9], getImage(allSigns[9])),
                          const SizedBox(width: 10),
                          optionsContainer(
                              allSigns[10], getImage(allSigns[10])),
                          const SizedBox(width: 10),
                          optionsContainer(
                              allSigns[11], getImage(allSigns[11])),
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

  // Generate two random incorrect answers and store them in the incorrectAnswers list
  void getRandomIncorrectAnswers() {
    setState(() {
      incorrectAnswers.clear();
      List<String> tempOptions = List.from(allSigns);
      tempOptions
          .remove(correctAnswer); // Remove the correct answer from the pool
      tempOptions.shuffle();
      incorrectAnswers =
          tempOptions.take(6).toList(); // Select two incorrect answers
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
          audioService.stopSound();
          onOptionClick(
              audioService: audioService,
              level: 3,
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
            ? Center(
                child: Image.asset('assets/images/cross-with-bg.png',
                    width: width * 0.16,
                    height: width * 0.16)) // Show cross for incorrect answers
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

  Future<void> showNextQuestion() async {
    MapEntry<String, String> randomQuestion = await getRandomQuestion();
    setState(() {
      correctAnswer = randomQuestion.key;
      question = randomQuestion.value;
      selectedAnswer = '';
      incorrectAnswers = [];
      isUsed50 = false;
      allSigns = List.from(GlobalVariables.allSigns);
      allSigns.shuffle();
      List<String> correctSounds = List.from(GlobalVariables.correctAnsSounds);
      correctSounds.shuffle();
      randomCorrectSound = correctSounds[0];
      List<String> incorrectSounds =
      List.from(GlobalVariables.incorrectAnsSounds);
      incorrectSounds.shuffle();
      randomIncorrectSound = incorrectSounds[0];
    });
  }
}
