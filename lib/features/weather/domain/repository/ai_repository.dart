import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';

abstract class AIRepository {
  Future<List<dynamic>> getPredictionFromWeatherData(ResponseEntity weatherData);
}
