
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/util/fail.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';
import 'package:weather_app/features/weather/domain/usecase/forecast_usecase.dart';

part 'forecast_state.dart';
@injectable
class ForecastCubit extends Cubit<ForecastState> {
  ForecastUseCase forecastUseCase;
  List<ForecastdayEntity> forecastList = [];

  ForecastCubit(Object object, {required this.forecastUseCase})
      : super(ForecastInitialState());

  getForecast(String city) async {
    emit(ForecastLoadingState());
    var data = await forecastUseCase.call(city);
    data.fold(
        (error) => emit(
              ForecastFailureState(failures: error),
            ), (forecastResponse) {
      forecastList = forecastResponse.forecast!.forecastday ?? [];
      emit(ForecastSuccessState(responseEntity: forecastResponse));
    });
  }
}
