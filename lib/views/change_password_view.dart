// lib/views/change_password_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/change_password_viewmodel.dart';

class ChangePasswordView extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body: Consumer<ChangePasswordViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  viewModel.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await viewModel.changePassword(_passwordController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password Changed Successfully')),
                            );
                          },
                          child: Text('Change Password'),
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