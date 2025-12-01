import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ImOkayApp());
}

class ImOkayApp extends StatelessWidget {
  const ImOkayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
