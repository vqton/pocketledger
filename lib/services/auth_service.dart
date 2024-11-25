// lib/services/auth_service.dart
import 'package:local_auth/local_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      print('Error checking biometrics: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('Error getting available biometrics: $e');
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  Future<UserModel?> loginWithBiometrics() async {
    bool authenticated = await authenticateWithBiometrics();
    if (authenticated) {
      // Simulate fetching user data after successful biometric authentication
      return UserModel(id: '1', name: 'John Doe', email: 'john.doe@example.com');
    }
    return null;
  }

  Future<UserModel?> loginWithEmail(String email, String password) async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));
    if (email == 'user@example.com' && password == 'password') {
      return UserModel(id: '1', name: 'John Doe', email: email);
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate sending a password reset email
    await Future.delayed(Duration(seconds: 2));
    print('Password reset email sent to $email');
  }

  Future<UserModel?> register(String name, String email, String password) async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));
    return UserModel(id: '2', name: name, email: email);
  }

  Future<void> changePassword(String newPassword) async {
    // Simulate changing the password
    await Future.delayed(Duration(seconds: 2));
    print('Password changed to $newPassword');
  }
}