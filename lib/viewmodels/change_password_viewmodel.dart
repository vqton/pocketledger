// lib/viewmodels/change_password_viewmodel.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> changePassword(String newPassword) async {
    _isLoading = true;
    notifyListeners();

    await _authService.changePassword(newPassword);

    _isLoading = false;
    notifyListeners();
  }
}