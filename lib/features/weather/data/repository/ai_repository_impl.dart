import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';
import 'package:weather_app/features/weather/domain/repository/ai_repository.dart';

class AIRepositoryImpl implements AIRepository {
  @override
  Future<List<dynamic>> getPredictionFromWeatherData(ResponseEntity weatherData) async {
    final url = Uri.parse('http://192.168.1.11:5001/predict');

    // Convert API weather data to AI model input format
    List<int> features = _convertWeatherToFeatures(weatherData);

    // Create the POST request body
    Map<String, dynamic> body = {
      'features': [features] // Wrap in a list to make it a 2D array
    };

    // Send the POST request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['prediction']; // Returns a list<dynamic>
    } else {
      throw Exception('Failed to get prediction');
    }
  }

  // Converts weather data into 5 binary features
  List<int> _convertWeatherToFeatures(ResponseEntity weatherData) {
    return [
      weatherData.current?.condition?.text?.toLowerCase().contains("rain") == true ? 1 : 0, // Rainy
      weatherData.current?.condition?.text?.toLowerCase().contains("sunny") == true ? 1 : 0, // Sunny
      weatherData.current?.tempC != null && weatherData.current!.tempC! > 30 ? 1 : 0, // Hot
      weatherData.current?.tempC != null &&
              weatherData.current!.tempC! >= 15 &&
              weatherData.current!.tempC! <= 30
          ? 1
          : 0,
      weatherData.current?.humidity != null && weatherData.current!.humidity! < 70 ? 1 : 0, // Normal Humidity
    ];
  }
}
