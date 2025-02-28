import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/screens/login_screen.dart';
import 'package:weather_app/features/auth/presentation/screens/onbording.dart';
import 'package:weather_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:weather_app/features/weather/data/repository/ai_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecase/predict_tennis_usecase.dart';
import 'package:weather_app/features/weather/presentation/controller/cubit/ai_cubit.dart';
import 'package:weather_app/features/weather/presentation/controller/cubit/forecast_cubit.dart';
import 'package:weather_app/features/weather/presentation/screens/home.dart';
import 'package:weather_app/injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<ForecastCubit>()),
        BlocProvider(create: (_) => sl<AICubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/onboarding",
        routes: {
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignUpScreen(),
          "/onboarding": (context) => const OnboardingScreen(),
          "/sixday": (context) => ForecastPage(),
        },
      ),
    );
  }
}
