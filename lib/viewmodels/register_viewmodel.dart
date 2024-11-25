// lib/viewmodels/register_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/analytics_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final AnalyticsService _analyticsService = AnalyticsService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserModel?> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    UserModel? user = await _authService.register(name, email, password);
    if (user != null) {
      await _analyticsService.logSignUp();
    }

    _isLoading = false;
    notifyListeners();
    return user;
  }
}