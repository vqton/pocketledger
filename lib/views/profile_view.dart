// lib/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${viewModel.user!.name}'),
                  Text('Email: ${viewModel.user!.email}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.logout();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text('Logout'),
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