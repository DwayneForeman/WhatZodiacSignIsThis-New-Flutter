import '../horoscope/model.dart';
import 'database_model.dart';
import 'database_service.dart';

Future<void> saveHoroscopeDataInDatabase(HoroscopeData horoscopeData,
    {required String date, required String day}) async {
  // Create an instance of HoroscopeDatabaseModel from the fetched HoroscopeData
  HoroscopeDatabaseModel horoscopeModel = HoroscopeDatabaseModel(
    date: date,
    relationship: horoscopeData.prediction.personal,
    health: horoscopeData.prediction.health,
    travel: horoscopeData.prediction.travel,
    luck: horoscopeData.prediction.luck.join('\n\n'),
    profession: horoscopeData.prediction.profession,
    emotions: horoscopeData.prediction.emotions,
  );

  // Create an instance of the HoroscopeDatabase class
  final horoscopeDB = HoroscopeDatabase();

  // Insert the horoscope data into the respective table (e.g., 'aries', 'gemini', etc.)
  await horoscopeDB.insertHoroscopeData(horoscopeData.sign, horoscopeModel);

  print("Horoscope data inserted for ${horoscopeData.sign}");
}
