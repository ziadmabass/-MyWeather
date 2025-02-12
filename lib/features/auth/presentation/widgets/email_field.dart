import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
   EmailField({super.key,required this.controller,required this.icon,required this.tybe});
TextEditingController controller ;
String tybe;
IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: tybe,
                  prefixIcon: Icon(icon, color: Colors.white70),
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