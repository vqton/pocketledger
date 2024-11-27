// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/login_view.dart' as login;
import 'views/register_view.dart' as register;
import 'views/profile_view.dart';
import 'views/change_password_view.dart';
import 'views/forgot_password_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => login.LoginView(),
        '/register': (context) => register.RegisterView(),
        '/profile': (context) => ProfileView(),
        '/change-password': (context) => ChangePasswordView(),
        '/forgot-password': (context) => ForgotPasswordView(),
      },
    );
  }
}