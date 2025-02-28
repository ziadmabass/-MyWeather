import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


@singleton
class ApiManger {
  late Dio dio;

  ApiManger() {
    dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<Response> getWeather({
    Map<String, dynamic>? headers,
    String? city,
  }) {
    String endpoint = city != null
        ? 'http://api.weatherapi.com/v1/forecast.json?key=da8379bc78124e0190a112307251702&q=$city&aqi=no'
        : 'http://api.weatherapi.com/v1/forecast.json?key=da8379bc78124e0190a112307251702&q=London&aqi=no';
    return dio.get(
      endpoint,
      options: Options(headers: headers, validateStatus: (status) => true),
    );
  }

  Future<Response> getForecast(String city,
      {Map<String, dynamic>? headers}) {
    return dio.get(
      'http://api.weatherapi.com/v1/forecast.json?key=da8379bc78124e0190a112307251702&q=$city&days=7',
      options: Options(
        headers: headers,
        validateStatus: (status) => true,
      ),
    );
  }


   Future<void> getPredictionFromWeatherData(ResponseEntity weatherData) async {
  final url = Uri.parse('http://10.0.2.2:5001/predict');

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

  // Handle the response
  if (response.statusCode == 200) {
    final prediction = json.decode(response.body)['prediction'];

    if (kDebugMode) {
      print('Prediction: $prediction');
    }

    // Show result in a dialog
    _showPredictionDialog(prediction);
  } else {
    if (kDebugMode) {
      print('Failed to get prediction');
    }
  }
}

// Function to process API weather data into AI model input format
List<int> _convertWeatherToFeatures(ResponseEntity weatherData) {
  return [
    weatherData.current?.condition!.text?.toLowerCase().contains("rain") == true ? 1 : 0, // Rainy
    weatherData.current?.condition?.text?.toLowerCase().contains("sunny") == true ? 1 : 0, // Sunny
    weatherData.current?.tempC != null && weatherData.current!.tempC! > 30 ? 1 : 0, // Hot
    weatherData.current?.tempC != null &&
            weatherData.current!.tempC! >= 15 &&
            weatherData.current!.tempC! <= 30
        ? 1
        : 0, // Mild
    weatherData.current?.humidity != null && weatherData.current!.humidity! < 70 ? 1 : 0, // Normal Humidity
  ];
}

// Function to show prediction result in a dialog
void _showPredictionDialog(int prediction) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text("Tennis Prediction"),
        content: Text(prediction == 1
            ? "You can play tennis today! 🎾"
            : "Better stay indoors today. ❌"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}


}