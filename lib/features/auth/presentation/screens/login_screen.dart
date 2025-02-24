import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/presentation/widgets/email_field.dart';
import 'package:weather_app/features/auth/presentation/widgets/log_button.dart';
import 'package:weather_app/features/auth/presentation/widgets/pass_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B1B2F), Color(0xFF162447)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80), // Top spacing
              // App Logo or Icon with animation
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 2),
                child: const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Welcome Text with animation
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 2),
                child: const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              // Email Input Field
              EmailField(
                  controller: emailController,
                  icon: Icons.email,
                  tybe: 'Email'),
              const SizedBox(height: 15),

              // Password Input Field
              PassField(controller: passwordController),
              const SizedBox(height: 20),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login Successful",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Navigate after successful login
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/sixday",
                      (route) => false,
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login failed",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: LogButton(
                      onPressed: () {
                        context.read<AuthCubit>().login(
                              emailController.text,
                              passwordController.text,
                            );
                      },
                      tybe: 'Login',
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              // Signup Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
