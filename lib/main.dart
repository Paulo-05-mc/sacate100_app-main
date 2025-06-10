import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const Sacate100App());
}

class Sacate100App extends StatelessWidget {
  const Sacate100App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sacate100',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );  
  }
}
