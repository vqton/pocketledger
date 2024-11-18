import 'package:flutter/material.dart';
import 'package:pocketledger/features/accounts/accounts_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketledger/features/budgets/budgets_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'core/config/setting_screen.dart';
import 'features/goals/goals_screen.dart';
import 'core/themes/app_theme.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Ledger',
      theme: appTheme,
      home: _currentUser == null
          ? OnboardingScreen()
          : HomeScreen(user: _currentUser!),
      routes: {
        '/login': (context) => LoginScreen(googleSignIn: _googleSignIn),
        '/home': (context) => HomeScreen(user: _currentUser!),
        '/settings': (context) => SettingsScreen(),
        '/goals': (context) => GoalsScreen(), // Add the goals route
        '/budgets': (context) => BudgetScreen(), // Add the budgets route
        '/accounts': (context) => AccountsScreen(),
      },
    );
  }
}
