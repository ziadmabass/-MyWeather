import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manger.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/data/model/response_model.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';



abstract class ForecastDataSource {
  Future<Either<Failures, ResponseEntity>> getForecast(String city);
}

// @Injectable(as: ForecastDataSource)
// class ForecastRemoteDataSource implements ForecastDataSource {
//   ApiManger apiManger;

//   ForecastRemoteDataSource({required this.apiManger});

//   @override
//   Future<Either<Failures, ResponseEntity>> getForecast(String city) async {
//     try {
//       var response = await apiManger.getForecast(city);
//       var ForecastResponse = ResponseModel.fromJson(response.data);
//       if (response.statusCode! >= 200 && response.statusCode! <= 299) {
//         return Right(ForecastResponse);
//       } else {
//         return Left(
//           ServerError(ErrorMessage: response.statusMessage!),
//         );
//       }
//     } catch (e) {
//       return Left(
//         ServerError(
//           ErrorMessage: e.toString(),
//         ),
//       );
//     }
//   }
// }