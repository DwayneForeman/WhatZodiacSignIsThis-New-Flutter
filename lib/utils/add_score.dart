import 'package:games_services/games_services.dart';

Future<void> submitScore(int score) async {
  await GamesServices.submitScore(
    score: Score(
        androidLeaderboardID: 'CgkImMyHs-MNEAIQAQ',
        value: score,
    ),
  );
}
