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

  Future<bool> clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('access_token');
  }

  Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<int> getKelasId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('kelas_id') ?? 0;
  }

  Future<bool> setKelasId(int kelasId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('kelas_id', kelasId);
  }

  Future<String> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_user') ?? '';
  }

  Future<bool> setIdUser(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id_user', token);
  }
}
