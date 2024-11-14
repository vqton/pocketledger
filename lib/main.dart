import 'package:flutter/material.dart';
import 'features\\onboarding\\onboarding_screen.dart';
import 'features\\auth\\login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        //   '/home': (context) => HomeScreen(),
      },
    );
  }
}
