import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_model.dart';

class HoroscopeDatabase {
  static final HoroscopeDatabase instance = HoroscopeDatabase._internal();
  Database? _database;

  factory HoroscopeDatabase() {
    return instance;
  }

  HoroscopeDatabase._internal();

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database and create tables for each zodiac sign
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'horoscope.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // List of zodiac signs
        List<String> zodiacSigns = [
          'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo', 'libra', 'scorpio',
          'sagittarius', 'capricorn', 'aquarius', 'pisces'
        ];

        // Loop through each zodiac sign and create a table for it
        for (String sign in zodiacSigns) {
          await db.execute('''
            CREATE TABLE $sign (
              date TEXT PRIMARY KEY,
              relationship TEXT,
              health TEXT,
              profession TEXT,
              emotions TEXT,
              travel TEXT,
              luck TEXT
            )
          ''');
        }
      },
    );
  }

  // Insert Horoscope data into the table for a specific zodiac sign
  Future<void> insertHoroscopeData(String sign, HoroscopeDatabaseModel horoscope) async {
    final db = await database;
    await db.insert(
      sign, // Table name passed dynamically (e.g., 'aries', 'taurus', etc.)
      horoscope.toMap(), // Data to insert
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if a conflict occurs (same date)
    );
  }
}
