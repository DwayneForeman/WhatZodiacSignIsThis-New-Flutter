import 'package:games_services/games_services.dart';
import 'package:whatsignisthis/utils/variables.dart';

Future<void> showLeaderboard() async {
  await GamesServices.showLeaderboards(
    androidLeaderboardID: GlobalVariables.to.androidLeaderBoardID,
    iOSLeaderboardID: GlobalVariables.to.iosLeaderBoardID,
  );
}
