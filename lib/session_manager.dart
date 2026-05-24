import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String keyLogin = 'isLoggedIn';
  static const String keyUsername = 'username';
  static const String keyEmail = 'email';

  static Future<void> loginUser({
    required String username,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLogin, true);
    await prefs.setString(keyUsername, username);

    if (email != null && email.isNotEmpty) {
      await prefs.setString(keyEmail, email);
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLogin) ?? false;
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyLogin);
    await prefs.remove(keyUsername);
    await prefs.remove(keyEmail);
  }
}
