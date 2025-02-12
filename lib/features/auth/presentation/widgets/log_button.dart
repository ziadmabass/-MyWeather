import 'package:flutter/material.dart';

class LogButton extends StatelessWidget {
   LogButton({super.key,required this.onPressed,required this.tybe});
void Function()? onPressed;
String tybe;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                      onPressed:onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child:  Text(
                        tybe,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
  }
}