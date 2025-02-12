import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/presentation/widgets/email_field.dart';
import 'package:weather_app/features/auth/presentation/widgets/log_button.dart';
import 'package:weather_app/features/auth/presentation/widgets/pass_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignUpScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo or Icon
              const Icon(
                Icons.person_add,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 20),

              // Welcome Text
              const Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign up to get started",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              // Name Input Field
              EmailField(
                  controller: nameController,
                  icon: Icons.person,
                  tybe: 'Name'),
              const SizedBox(height: 15),
              // Email Input Field

              EmailField(
                  controller: emailController,
                  icon: Icons.email,
                  tybe: 'email'),
              const SizedBox(height: 15),
              // Password Input Field
              PassField(controller: passwordController),
              const SizedBox(height: 20),

              // Bloc Consumer for Signup Button
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Signup successful!",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Signup failed",
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
                      onPressed: () {Navigator.pushNamed(context, "/login");},
                      tybe: "Sign Up",
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              // Login Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
