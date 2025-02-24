import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/data/data_source/forecast_data_source.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';
import 'package:weather_app/features/weather/domain/repository/forecast_repository.dart';

@Injectable(as: ForecastRepo)
class ForecastRepoImpl implements ForecastRepo {
  ForecastDataSource forecastDataSource;

  ForecastRepoImpl(this.forecastDataSource);

  @override
  Future<Either<Failures, ResponseEntity>> getForecast(String city) async {
    var data = await forecastDataSource.getForecast(city);
    return data.fold(
      (error) => left(error),
      (response) => right(response),
    );
  }
}
