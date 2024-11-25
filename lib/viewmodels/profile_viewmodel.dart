// lib/viewmodels/profile_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/session_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();
  UserModel? _user;
  UserModel? get user => _user;

  Future<void> loadUserProfile() async {
    String? userId = await _sessionService.getSession();
    if (userId != null) {
      // Simulate fetching user data
      _user = UserModel(id: userId, name: 'John Doe', email: 'john.doe@example.com');
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _sessionService.clearSession();
    _user = null;
    notifyListeners();
  }
}