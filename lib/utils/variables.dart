import 'package:get/get.dart';
import 'package:whatsignisthis/utils/audio_services.dart';

class GlobalVariables {

  static GlobalVariables get to => Get.find<GlobalVariables>();

  RxInt points = 0.obs;
  RxInt newInstallQuestionToShow = 3.obs;
  RxBool disableSound = false.obs;
  RxBool isGameOver = false.obs;
  RxBool showNextQuestion = true.obs;

  static List<String> correctAnsSounds = [
    'assets/sounds/correct-ans1.mpeg',
    'assets/sounds/correct-ans2.mpeg',
    'assets/sounds/correct-ans3.mpeg',
    'assets/sounds/correct-ans4.mpeg',
  ];

  static List<String> incorrectAnsSounds = [
    'assets/sounds/incorrect-ans1.mpeg',
    'assets/sounds/incorrect-ans2.mpeg',
    'assets/sounds/incorrect-ans3.mpeg',
    'assets/sounds/incorrect-ans4.mpeg',
  ];

  static List<String> allSigns = [
    'Aries',
    'Taurus',
    'Cancer',
    'Gemini',
    'Aquarius',
    'Virgo',
    'Capricorn',
    'Leo',
    'Libra',
    'Pisces',
    'Scorpio',
    'Sagittarius'
  ];
}
