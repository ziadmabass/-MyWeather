import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repository.dart';
import 'package:weather_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:weather_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl())); 
}
