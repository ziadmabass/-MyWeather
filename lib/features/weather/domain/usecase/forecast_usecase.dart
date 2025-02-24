import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';
import 'package:weather_app/features/weather/domain/repository/forecast_repository.dart';


@injectable
class ForecastUseCase {
  ForecastRepo forecastRepo;

  ForecastUseCase(this.forecastRepo);

  Future<Either<Failures, ResponseEntity>> call(String city) =>
      forecastRepo.getForecast(city);
}