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

  Future<String> getIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_user') ?? '';
  }

  Future<bool> setIdUser(final String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('id_user', token);
  }

  Future<bool> setTodayAbsen(final int idPelajaran) async {
    final date = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('today_absen_${date.day}_$idPelajaran', true);
  }

  Future<bool?> getAbsenToday(final int idPelajaran) async {
    final date = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("today_absen_${date.day}_$idPelajaran");
  }
}
