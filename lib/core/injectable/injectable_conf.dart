import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:weather_app/features/weather/data/data_source/forcast_data_source_imp.dart' as _i339;
import 'package:weather_app/features/weather/domain/repository/forecast_repository.dart' as _i86;
import 'package:weather_app/features/weather/data/repository/forecast_repo_imp.dart' as _i369;
import 'package:weather_app/features/weather/domain/usecase/forecast_usecase.dart' as _i405;
import 'package:weather_app/features/weather/presentation/controller/cubit/forecast_cubit.dart' as _i510; // Import ForecastCubit
import '../../features/weather/data/data_source/forecast_data_source.dart' as _i514;
import '../api/api_manger.dart' as _i339;

extension GetItInjectableX on _i174.GetIt {
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i339.ApiManger>(() => _i339.ApiManger());

    // Register ForecastDataSource
    gh.factory<_i514.ForecastDataSource>(
        () => _i339.ForcastDataSourceImp(apiManger: gh<_i339.ApiManger>(), api: gh<_i339.ApiManger>()));

    // Register ForecastRepo
    gh.factory<_i86.ForecastRepo>(
        () => _i369.ForecastRepoImpl(gh<_i514.ForecastDataSource>()));

    // Register ForecastUseCase
    gh.factory<_i405.ForecastUseCase>(
        () => _i405.ForecastUseCase(gh<_i86.ForecastRepo>()));

    // ✅ Register ForecastCubit (Missing part that caused the error)
    gh.factory<_i510.ForecastCubit>(
        () => _i510.ForecastCubit(gh<_i405.ForecastUseCase>(), forecastUseCase: gh<_i405.ForecastUseCase>()));

    return this;
  }
}
