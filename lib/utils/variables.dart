import 'package:get/get.dart';

class GlobalVariables {

  static GlobalVariables get to => Get.find<GlobalVariables>();

  RxInt points = 0.obs;
  RxInt highScores = 100.obs;
  RxInt newInstallQuestionToShow = 3.obs;
  RxBool disableSound = false.obs;
  RxBool isGameOver = false.obs;
  RxBool showHighScoreDialog = true.obs;
  RxBool showNextQuestion = true.obs;
  RxString weeklyPrice = '\$6.99'.obs;
  String androidLeaderBoardID = 'CgkImMyHs-MNEAIQAQ';
  String iosLeaderBoardID = 'zodiacmemelords';
  String horoscopeApiKey = '9ff0525c64bf3d4c9957a1d4397f1b40';
  String horoscopeAccessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FzdHJvYXBpLTEuZGl2aW5lYXBpLmNvbS9hcGkvYXV0aC1hcGktdXNlciIsImlhdCI6MTczMTg5NTc2OCwibmJmIjoxNzMxODk1NzY4LCJqdGkiOiJoTmhyZlRzRURqM2dQbHdPIiwic3ViIjoiMjk4MSIsInBydiI6ImU2ZTY0YmIwYjYxMjZkNzNjNmI5N2FmYzNiNDY0ZDk4NWY0NmM5ZDcifQ.p6jwvgEAPlzND7HA6JPvvJeMaUU1DhHH1z9CUyco2DI';
  String horoscopeSelectedSign = 'ARIES';

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
