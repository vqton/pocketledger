// lib/viewmodels/login_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/session_service.dart';
import '../services/analytics_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();
  final AnalyticsService _analyticsService = AnalyticsService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> canCheckBiometrics() async {
    return await _authService.canCheckBiometrics();
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _authService.getAvailableBiometrics();
  }

  Future<UserModel?> loginWithBiometrics() async {
    _isLoading = true;
    notifyListeners();

    UserModel? user = await _authService.loginWithBiometrics();
    if (user != null) {
      await _sessionService.saveSession(user.id);
      await _analyticsService.logLogin('biometrics');
    }

    _isLoading = false;
    notifyListeners();
    return user;
  }

  Future<UserModel?> loginWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    UserModel? user = await _authService.loginWithEmail(email, password);
    if (user != null) {
      await _sessionService.saveSession(user.id);
      await _analyticsService.logLogin('email');
    }

    _isLoading = false;
    notifyListeners();
    return user;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }
}
