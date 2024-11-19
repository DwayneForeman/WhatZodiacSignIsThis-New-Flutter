import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatsignisthis/utils/variables.dart';

import 'model.dart';

class HoroscopeController {
  Future<HoroscopeData> fetchHoroscopeData({
    required String sign,
    required String day,
    required String apiKey,
    required String accessToken,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://astroapi-5.divineapi.com/api/v2/daily-horoscope'),
        headers: {
          'Authorization': 'Bearer ${GlobalVariables.to.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'api_key': GlobalVariables.to.apiKey,
          'sign': sign,
          'day': day,
          'month': DateTime.now().month.toString(),
          'year': DateTime.now().year.toString(),
          //'tzone': DateTime.now().timeZoneOffset.inHours + DateTime.now().timeZoneOffset.inMinutes / 60.0,
          'tzone': 5.5,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          // Map the response to the model
          return HoroscopeData.fromJson(responseData['data']);
        } else {
          throw Exception('Failed to fetch horoscope data');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching horoscope: $e');
    }
  }
}

//
//
// Expanded(
// child: FutureBuilder<HoroscopeData>(
// future: fetchHoroscopeData(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Center(child: CircularProgressIndicator());
// } else if (snapshot.hasError) {
// return Center(child: Text('Error: ${snapshot.error}'));
// } else if (!snapshot.hasData) {
// return Center(child: Text('No data available'));
// } else {
// // Parse and display the data from the API
// final horoscopeData = snapshot.data!;
//
// return Padding(
// padding: const EdgeInsets.all(16.0),
// child: ListView(
// children: [
// Text('Sign: ${horoscopeData.sign}', style: TextStyle(fontSize: 20)),
// SizedBox(height: 8),
// Text('Personal: ${horoscopeData.prediction.personal}', style: TextStyle(fontSize: 16)),
// SizedBox(height: 8),
// Text('Health: ${horoscopeData.prediction.health}', style: TextStyle(fontSize: 16)),
// SizedBox(height: 8),
// Text('Profession: ${horoscopeData.prediction.profession}', style: TextStyle(fontSize: 16)),
// SizedBox(height: 8),
// Text('Emotions: ${horoscopeData.prediction.emotions}', style: TextStyle(fontSize: 16)),
// SizedBox(height: 8),
// Text('Travel: ${horoscopeData.prediction.travel}', style: TextStyle(fontSize: 16)),
// SizedBox(height: 8),
// Text('Luck: ${horoscopeData.prediction.luck.join(', ')}', style: TextStyle(fontSize: 16)),
// ],
// ),
// );
// }
// },
// ),
// ),