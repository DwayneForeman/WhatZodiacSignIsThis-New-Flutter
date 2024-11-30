import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatsignisthis/utils/variables.dart';

import 'model.dart';

class HoroscopeController {
  Future<HoroscopeData> fetchHoroscopeData({
    required String sign,
    required String day,
    required String month,
    required String year,
    required String apiKey,
    required String accessToken,
    required String tzone
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://astroapi-5.divineapi.com/api/v2/daily-horoscope'),
        headers: {
          'Authorization': 'Bearer ${GlobalVariables.to.horoscopeAccessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'api_key': GlobalVariables.to.horoscopeApiKey,
          'sign': sign,
          'day': day,
          'month': month,
          'year': year,
          'tzone': tzone,
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
