import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/utils/variables.dart';

Future<void> disableSound() async {
  GlobalVariables.to.disableSound.value = !GlobalVariables.to.disableSound.value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('soundOff', GlobalVariables.to.disableSound.value);
}