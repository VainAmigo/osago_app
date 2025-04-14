import 'package:flutter/material.dart';
import 'package:osago_bloc_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osago_bloc_app/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}