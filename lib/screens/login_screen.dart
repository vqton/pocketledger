import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;

  LoginScreen({required this.authService});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png', height: 100), // App logo
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email), // Email icon
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock), // Password icon
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        Text('Remember Me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // Use the authService for login
                    /*bool success =
                        await widget.authService.login('email', 'password');*/
                    bool success = await widget.authService
                        .login('user@example.com', 'password123');
                    print('Login success: $success'); // Debugging line
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterScreen(authService: widget.authService)),
                    );
                  },
                  child: Text('Register'),
                ),
                SizedBox(height: 16.0),
                Text('Or login with'),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.google), // Google icon
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook), // Facebook icon
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                    IconButton(
                      icon:
                          FaIcon(FontAwesomeIcons.twitter), // X (Twitter) icon
                      onPressed: () {
                        // Handle X login
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
