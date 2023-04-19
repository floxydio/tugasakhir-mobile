import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  Future<bool> setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', token);
  }
}
