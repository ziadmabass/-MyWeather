import 'package:flutter/material.dart';

class PassField extends StatelessWidget {
   PassField({super.key,required this.controller});
 TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: controller ,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: const TextStyle(color: Colors.white70),
                ),
              );
  }
}