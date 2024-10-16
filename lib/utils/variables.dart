import 'package:get/get.dart';

class GlobalVariables{
  static GlobalVariables get to => Get.find<GlobalVariables>();

  RxInt points = 0.obs;
  RxInt newInstallQuestionToShow = 3.obs;
  RxBool disableSound = false.obs;
  RxBool isGameOver = false.obs;
}