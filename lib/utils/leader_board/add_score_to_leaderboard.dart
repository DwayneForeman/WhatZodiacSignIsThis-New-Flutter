import 'package:games_services/games_services.dart';
import 'package:whatsignisthis/utils/variables.dart';

Future<void> submitScore(int score) async {
  bool isSignedIn = await GameAuth.isSignedIn;
  if (isSignedIn) {
    await GamesServices.submitScore(
      score: Score(
        androidLeaderboardID: GlobalVariables.to.androidLeaderBoardID,
        iOSLeaderboardID: GlobalVariables.to.iosLeaderBoardID,
        value: score,
      ),
    );
  }
}
