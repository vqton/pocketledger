import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthManager {
  // Configurations for Google and Facebook OAuth
  final String googleClientId =
      "609571773604-v10cs1gahcaisodq5m8hjibc2dub50m5.apps.googleusercontent.com";
  final String facebookClientId = "YOUR_FACEBOOK_CLIENT_ID";

  Future<Map<String, dynamic>> authenticateWithProvider(
      String provider, String authCode) async {
    if (provider == "Google") {
      return await authenticateWithGoogle(authCode);
    } else if (provider == "Facebook") {
      return await authenticateWithFacebook(authCode);
    } else {
      throw Exception("Unsupported provider");
    }
  }

  Future<Map<String, dynamic>> authenticateWithGoogle(String authCode) async {
    // Implement Google OAuth flow to get user data
    try {
      // Exchange auth code for tokens
      final tokenEndpoint = Uri.parse('https://oauth2.googleapis.com/token');
      final response = await http.post(
        tokenEndpoint,
        body: {
          'code': authCode,
          'client_id': googleClientId,
          'grant_type': 'authorization_code',
          'redirect_uri':
              'com.pockerledger:/oauth2redirect', // Match your app's redirect URI
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to exchange auth code for tokens');
      }

      final tokens = jsonDecode(response.body);
      final accessToken = tokens['access_token'];

      // Get user info using access token
      final userInfoEndpoint =
          Uri.parse('https://www.googleapis.com/oauth2/v2/userinfo');
      final userInfoResponse = await http.get(
        userInfoEndpoint,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (userInfoResponse.statusCode != 200) {
        throw Exception('Failed to get user info');
      }

      final userData = jsonDecode(userInfoResponse.body);
      return {
        'id': userData['id'],
        'email': userData['email'],
        'name': userData['name'],
        'picture': userData['picture'],
        'access_token': accessToken,
      };
    } catch (e) {
      throw Exception('Google authentication failed: ${e.toString()}');
    }
    // Exchange the auth code with Google for an access token and retrieve user data
    // Return user data as a map
    return {}; // Return empty map as placeholder until implementation
  }

  Future<Map<String, dynamic>> authenticateWithFacebook(String authCode) async {
    // Implement Facebook OAuth flow to get user data
    // Exchange the auth code with Facebook for an access token and retrieve user data
    // Return user data as a map

    return {}; // Return empty map as placeholder until implementation
  }
}
