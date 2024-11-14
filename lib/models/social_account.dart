// Social account model file
class SocialAccount {
  String userId;
  String provider; // Google or Facebook
  String providerUserId;
  String email;
  String accessToken;
  String refreshToken;
  DateTime tokenExpiry;

  SocialAccount(this.userId, this.provider, this.providerUserId, this.email,
      this.accessToken, this.refreshToken, this.tokenExpiry);

  void refreshAccessToken() {
    /// Refreshes the access token using the refresh token if expired.
    // Logic to refresh token
  }
}
