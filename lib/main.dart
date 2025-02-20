import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/injection_container.dart';
import 'package:weather_app/root/approot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator(); 
  runApp(const MyApp());
}

//z

