import 'package:sqflite/sqflite.dart';

Future<void> deleteEntriesBeforeYesterday() async {
  try {
    // Open the horoscope database
    final Database db = await openDatabase('horoscope.db');

    // Get yesterday's date as a numeric value (e.g., 27 for the 27th of the month)
    int yesterday = DateTime.now().subtract(const Duration(days: 1)).day;

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
    ]; // Replace with actual table names if different

    // Begin a transaction for safe deletion
    await db.transaction((txn) async {
      if (yesterday == 1 || yesterday == 2) {
        // If the date is 1 or 2, delete all entries in all tables
        for (String table in tables) {
          await txn.delete(table); // Delete all rows without conditions
        }
        print("All entries deleted from all tables because yesterday was day $yesterday.");
      } else {
        // On other days, delete entries before yesterday
        for (String table in tables) {
          await txn.delete(
            table,
            where: 'date < ?',
            whereArgs: [yesterday],
          );
        }
        print("All entries before yesterday (date < $yesterday) deleted from the horoscope database.");
      }
    });
  } catch (e) {
    print("Error while deleting entries: $e");
  }
}
