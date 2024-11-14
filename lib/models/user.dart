// User model file
class User {
  String user_id;
  String name;
  String email;

  User(this.user_id, this.name, this.email);

  void linkSocialAccount(String provider, String providerUserId,
      String accessToken, String refreshToken, DateTime tokenExpiry) {
    /// Links a social account to the user's account.
    // Logic to link Google or Facebook account
  }
}
