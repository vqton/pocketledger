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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  Future<void> loadUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? userId = await _sessionService.getSession();
      if (userId != null) {
        // Simulate fetching user data
        _user = UserModel(
          id: userId,
          name: 'John Doe',
          email: 'john.doe@example.com',
          profilePictureUrl: 'https://iconduck.com/icons/180867/profile-circle?shared',
          phoneNumber: '123-456-7890',
        );
      } else {
        _error = 'User not found';
      }
    } catch (e) {
      _error = 'Failed to load user profile';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoggingOut = true;
    notifyListeners();

    await _sessionService.clearSession();
    _user = null;

    _isLoggingOut = false;
    notifyListeners();
  }
}
