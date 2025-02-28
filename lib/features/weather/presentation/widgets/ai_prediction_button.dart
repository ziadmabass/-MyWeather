import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/controller/cubit/ai_cubit.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';

class AIPredictionButton extends StatelessWidget {
  final ResponseEntity weatherData;

  const AIPredictionButton({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AICubit, AIState>(
      listener: (context, state) {
        if (state is AISuccess) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Text("Tennis Prediction"),
                content: Text(state.prediction == 1
                    ? "You can play tennis today! 🎾"
                    : "Better stay indoors today. ❌",),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            onPressed: () {
              context.read<AICubit>().fetchAIPrediction(weatherData);
              print(state);
            },
            child: state is AILoading
                ? CircularProgressIndicator()
                : Text("Should I Play Tennis?",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        );
      },
    );
  }
}
