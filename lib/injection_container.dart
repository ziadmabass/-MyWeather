import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manger.dart';
import 'package:weather_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repository.dart';
import 'package:weather_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:weather_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/weather/data/data_source/forcast_data_source_imp.dart';
import 'package:weather_app/features/weather/data/data_source/forecast_data_source.dart';
import 'package:weather_app/features/weather/data/repository/ai_repository_impl.dart';
import 'package:weather_app/features/weather/data/repository/forecast_repo_imp.dart';
import 'package:weather_app/features/weather/domain/repository/ai_repository.dart';
import 'package:weather_app/features/weather/domain/repository/forecast_repository.dart';
import 'package:weather_app/features/weather/domain/usecase/forecast_usecase.dart';
import 'package:weather_app/features/weather/domain/usecase/predict_tennis_usecase.dart';
import 'package:weather_app/features/weather/presentation/controller/cubit/ai_cubit.dart';
import 'package:weather_app/features/weather/presentation/controller/cubit/forecast_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl()));


   // ✅ Register API Manager
  sl.registerLazySingleton<ApiManger>(() => ApiManger());

  // ✅ Register Data Source
  sl.registerLazySingleton<ForecastDataSource>(
      () => ForcastDataSourceImp(apiManger: sl<ApiManger>(), api: sl<ApiManger>()));

  // ✅ Register Repository
  sl.registerLazySingleton<ForecastRepo>(
      () => ForecastRepoImpl(sl<ForecastDataSource>()));

  // ✅ Register Use Case
  sl.registerLazySingleton<ForecastUseCase>(
      () => ForecastUseCase(sl<ForecastRepo>()));

  // ✅ Register ForecastCubit (THIS WAS MISSING!)
  sl.registerFactory<ForecastCubit>(() => ForecastCubit(sl<ForecastUseCase>(), forecastUseCase: sl<ForecastUseCase>()));


  
  sl.registerLazySingleton(() =>GetAIPrediction (sl()));
  sl.registerFactory(() => AICubit(sl()));
sl.registerLazySingleton<AIRepository>(() => AIRepositoryImpl());
  }

@module
abstract class AppModule {
 
}

