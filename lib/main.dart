import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pkart/firebase_options.dart';
import 'package:pkart/pages/home_page.dart';
import 'package:pkart/pages/login_page.dart';
import 'package:pkart/pages/register_page.dart';
import 'package:pkart/theme/dart_mode.dart';
import 'package:pkart/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      home: HomePage(),
    );
  }
}