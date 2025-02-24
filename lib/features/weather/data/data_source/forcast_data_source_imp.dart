import 'package:dartz/dartz.dart';
import 'package:weather_app/core/api/api_manger.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/data/data_source/forecast_data_source.dart';
import 'package:weather_app/features/weather/data/model/response_model.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';

class ForcastDataSourceImp implements ForecastDataSource {
  ApiManger api;
  ForcastDataSourceImp({required this.api, required ApiManger apiManger});
  @override
  Future<Either<Failures, ResponseEntity>> getForecast(String city) async {
   try {
      var response = await api.getForecast(city);
      var ForecastResponse = ResponseModel.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(ForecastResponse);
      } else {
        return Left(
          ServerError(ErrorMessage: response.statusMessage!),
        );
      }
    } catch (e) {
      return Left(
        NetworkError(
          ErrorMessage: e.toString(),
        ),
      );
    }
  }
  }

