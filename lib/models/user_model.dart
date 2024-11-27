// lib/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl; // Optional profile picture URL
  final String? phoneNumber; // Optional phone number

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.phoneNumber,
  });
}