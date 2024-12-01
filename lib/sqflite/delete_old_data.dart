import 'package:sqflite/sqflite.dart';

Future<void> deleteDatabaseEntriesBeforeYesterday() async {
  try {
    // Open the horoscope database
    final Database db = await openDatabase('horoscope.db');

    // Get yesterday's date at midnight (start of the day)
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));

    // Convert yesterday to the "yyyy-MM-dd" format
    String yesterdayString = "${yesterday.year}-${yesterday.month.toString()}-${yesterday.day.toString()}";

    // List of tables in the horoscope database
    List<String> tables = [
      'aries',
      'taurus',
      'gemini',
      'cancer',
      'leo',
      'virgo',
      'libra',
      'scorpio',
      'sagittarius',
      'capricorn',
      'aquarius',
      'pisces'
    ];

    // Begin a transaction for safe deletion
    await db.transaction((txn) async {
      for (String table in tables) {
        await txn.delete(
          table,
          where: 'date < ?',
          whereArgs: [yesterdayString],
        );
      }
    });

    print("All entries before $yesterdayString deleted from the horoscope database.");
  } catch (e) {
    print("Error while deleting entries: $e");
  }
}
