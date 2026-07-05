import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '2ce674fca2c9b0ae5fba5e0a4aeccecd';

  Future<Map<String, dynamic>> getWeather(
      double lat,
      double lon,
      ) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response =
    await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}