import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/screens/onbording.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/signup_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/onboarding",
        routes: {
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignUpScreen(),
          "/onboarding": (context) => const OnboardingScreen(),
        },
      ),
    );
  }
}
