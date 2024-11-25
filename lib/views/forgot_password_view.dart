// lib/views/forgot_password_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
        ),
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.sendPasswordResetEmail(_emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password Reset Email Sent')),
                      );
                    },
                    child: Text('Send Password Reset Email'),
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