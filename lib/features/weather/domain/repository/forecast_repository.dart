import 'package:dartz/dartz.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';

abstract class ForecastRepo {
  Future<Either<Failures, ResponseEntity>> getForecast(String city);
}