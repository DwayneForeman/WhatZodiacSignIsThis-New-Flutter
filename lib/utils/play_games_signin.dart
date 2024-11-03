import 'package:games_services/games_services.dart';

Future<void> playGamesSignin() async {
  bool isSignedIn = await GameAuth.isSignedIn;
  // if (!isSignedIn) {
  //   final result = await GameAuth.signIn();
  // }
}