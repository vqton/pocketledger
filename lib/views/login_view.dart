// lib/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pocketledger/models/user_model.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<bool>(
                    future: viewModel.canCheckBiometrics(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error checking biometrics');
                      } else if (!snapshot.data!) {
                        return Text('Biometric authentication is not available');
                      } else {
                        return FutureBuilder<List<BiometricType>>(
                          future: viewModel.getAvailableBiometrics(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error getting available biometrics');
                            } else if (snapshot.data!.isEmpty) {
                              return Text('No biometrics enrolled');
                            } else {
                              return Column(
                                children: [
                                  Text('Available biometrics: ${snapshot.data!.join(', ')}'),
                                  SizedBox(height: 20),
                                  viewModel.isLoading
                                      ? CircularProgressIndicator()
                                      : ElevatedButton(
                                          onPressed: () async {
                                            UserModel? user = await viewModel.loginWithBiometrics();
                                            if (user != null) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Login Successful: ${user.name}')),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Login Failed')),
                                              );
                                            }
                                          },
                                          child: Text('Login with Biometrics'),
                                        ),
                                ],
                              );
                            }
                          },
                        );
                      }
                    },
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