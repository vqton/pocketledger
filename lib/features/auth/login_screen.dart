// Login screen file
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketledger/features/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final GoogleSignIn googleSignIn;

  LoginScreen({required this.googleSignIn});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Implement your login logic here
      // After login logic
      setState(() {
        _isLoading = false;
      });
    }
  }

  // void _loginWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       // Use googleAuth.accessToken and googleAuth.idToken for your login logic
  //       // Implement your login logic here
  //       //MOVE TO DASHBOARD
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     }
  //   } catch (error) {
  //     print("Google Sign-In Error: $error"); // Handle error appropriately
  //   }
  // }
  void _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        // Navigate to HomeScreen with the googleUser parameter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(user: googleUser),
          ),
        );
      }
    } catch (error) {
      print("Google Sign-In Error: $error"); // Handle error appropriately
    }
  }

  void _loginWithFacebook() {
    // Implement Facebook login logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _loginWithGoogle,
                      icon: Icon(Icons.login),
                      label: Text('Login with Google'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _loginWithFacebook,
                      icon: Icon(Icons.login),
                      label: Text('Login with Facebook'),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Implement forgot password logic here
                      },
                      child: Text('Forgot Password?'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement sign up logic here
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
