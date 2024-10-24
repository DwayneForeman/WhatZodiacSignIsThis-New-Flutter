import 'package:games_services/games_services.dart';

Future<void> showLeaderboard() async {
  await GamesServices.showLeaderboards(
    androidLeaderboardID: 'CgkImMyHs-MNEAIQAQ',
  );
}
