import 'dart:convert';
import 'dart:io';
import 'dart:math';

class TokenManager {
  final String userId;
  final String filePath = 'TokenManager.json';

  TokenManager(this.userId);

  Future<void> createSessionToken() async {
    final token = _generateToken();
    await _saveTokenToFile(userId, token);
  }

  Future<bool> validateSessionToken(String accessToken) async {
    final tokenData = await _getTokenFromFile(accessToken);
    if (tokenData == null) {
      return false;
    }

    final createdAt = DateTime.parse(tokenData['createdAt']);
    final isActive = DateTime.now().difference(createdAt).inHours < 24;
    return isActive;
  }

  String _generateToken() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(32, (index) => characters[random.nextInt(characters.length)]).join();
  }

  Future<void> _saveTokenToFile(String userId, String token) async {
    final file = File(filePath);
    Map<String, dynamic> tokens = {};

    if (await file.exists()) {
      final content = await file.readAsString();
      tokens = jsonDecode(content);
    }

    tokens[token] = {
      'userId': userId,
      'createdAt': DateTime.now().toIso8601String(),
    };

    await file.writeAsString(jsonEncode(tokens));
  }

  Future<Map<String, dynamic>?> _getTokenFromFile(String token) async {
    final file = File(filePath);

    if (await file.exists()) {
      final content = await file.readAsString();
      final tokens = jsonDecode(content) as Map<String, dynamic>;

      if (tokens.containsKey(token)) {
        return tokens[token];
      }
    }

    return null;
  }
}
