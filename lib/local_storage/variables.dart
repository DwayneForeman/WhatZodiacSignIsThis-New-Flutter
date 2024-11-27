import 'package:get/get.dart';

class LocalVariables{
  static LocalVariables get to => Get.find<LocalVariables>();

  RxString todayAriesRelationship = ''.obs;
  RxString todayAriesHealth = ''.obs;
  RxString todayAriesProfession = ''.obs;
  RxString todayAriesEmotions = ''.obs;
  RxString todayAriesTravel = ''.obs;
  RxList<String> todayAriesLuck = <String>[].obs;
  RxString yesterdayAriesRelationship = ''.obs;
  RxString yesterdayAriesHealth = ''.obs;
  RxString yesterdayAriesProfession = ''.obs;
  RxString yesterdayAriesEmotions = ''.obs;
  RxString yesterdayAriesTravel = ''.obs;
  RxList<String> yesterdayAriesLuck = <String>[].obs;
  RxString tommorowAriesRelationship = ''.obs;
  RxString tommorowAriesHealth = ''.obs;
  RxString tommorowAriesProfession = ''.obs;
  RxString tommorowAriesEmotions = ''.obs;
  RxString tommorowAriesTravel = ''.obs;
  RxList<String> tommorowAriesLuck = <String>[].obs;

}