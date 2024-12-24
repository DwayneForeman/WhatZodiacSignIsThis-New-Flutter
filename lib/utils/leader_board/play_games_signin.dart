import 'package:games_services/games_services.dart';

Future<void> playGamesSignin() async {
  final isSignedIn = await GameAuth.signIn();
  print('Signin Log: ' + isSignedIn.toString());
  // if (!isSignedIn) {
  //   final result = await GameAuth.signIn();
  // }
}