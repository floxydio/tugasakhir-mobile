import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  Future<bool> setAccessToken(final String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', token);
  }

  Future<bool> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('access_token');
  }

  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<int> getKelasId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('kelas_id') ?? 0;
  }

  Future<bool> setKelasId(final int kelasId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('kelas_id', kelasId);
  }

  Future<int> getIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id_user') ?? 0;
  }

  Future<bool> setIdUser(final int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('id_user', id);
  }

  Future<bool> setTodayAbsen() async {
    final date = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('today_absen_${date.day}', true);
  }

  Future<bool?> getAbsenToday() async {
    final date = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("today_absen_${date.day}");
  }
}
