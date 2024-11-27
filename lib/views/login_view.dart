// lib/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pocketledger/models/user_model.dart';
import 'package:pocketledger/viewmodels/register_viewmodel.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_viewmodel.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo
                  Center(
                      child:
                          Image.asset('assets/images/logo.png', height: 100)),
                  const SizedBox(height: 20),
                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton.icon(
                          onPressed: () async {
                            UserModel? user = await viewModel.loginWithEmail(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Login Successful: ${user.name}'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login Failed'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                  const SizedBox(height: 20),
                  // Biometric Authentication Widget
                  BiometricAuthWidget(viewModel: viewModel),
                  const SizedBox(height: 20),
                  // Forgot Password Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // Navigate to password reset screen
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Forgot Password?'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  // Register Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterView()),
                        );
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Register'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BiometricAuthWidget extends StatelessWidget {
  final LoginViewModel viewModel;

  BiometricAuthWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: viewModel.canCheckBiometrics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error checking biometrics');
        } else if (!snapshot.data!) {
          return const Text('Biometric authentication is not available');
        } else {
          return FutureBuilder<List<BiometricType>>(
            future: viewModel.getAvailableBiometrics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error getting available biometrics');
              } else if (snapshot.data!.isEmpty) {
                return const Text('No biometrics enrolled');
              } else {
                return Column(
                  children: [
                    viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () async {
                              UserModel? user =
                                  await viewModel.loginWithBiometrics();
                              if (user != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Login Successful: ${user.name}'),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Failed'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.fingerprint),
                            label: const Text('Login with Biometrics'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
