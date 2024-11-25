import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/utils/variables.dart';

class Points{

  static Future<void> usePoints(int pointsToUse) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentPoints = GlobalVariables.to.points.value;
    await prefs.setInt('points', currentPoints - pointsToUse);
    GlobalVariables.to.points.value = currentPoints - pointsToUse;
  }

  static Future<void> addPoints(int pointsToAdd) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentPoints = GlobalVariables.to.points.value;
    await prefs.setInt('points', currentPoints + pointsToAdd);
    GlobalVariables.to.points.value = currentPoints + pointsToAdd;
  }

}