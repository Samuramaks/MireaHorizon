import 'package:shared_preferences/shared_preferences.dart';

class SPRepository {
  final SharedPreferences preferences;

  SPRepository({required this.preferences});

  Future<bool?> getBoolLocalData(String key) async {
    return Future.value(preferences.getBool(key));
  }

  Future<int?> getIntLocalData(String key) async {
    return Future.value(preferences.getInt(key));
  }

  Future<String?> getStringLocalData(String key) async {
    return Future.value(preferences.getString(key));
  }

  Future<void> setBoolLocalData(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  Future<void> setIntLocalData(String key, int value) async {
    await preferences.setInt(key, value);
  }

  Future<void> setStringLocalData(String key, String value) async {
    await preferences.setString(key, value);
  }

  Future<void> clearLocalData() async {
    await preferences.clear();
  }

  Future<bool> isFirstLaunch() async {
    bool? isFirstLaunch = await getBoolLocalData('isFirstLaunch');
    if (isFirstLaunch == null || isFirstLaunch) {
      await setBoolLocalData('isFirstLaunch', false);
      return true;
    }
    return false;
  }

  // Метод для сохранения имени пользователя
  Future<void> setUsername(String username) async {
    await preferences.setString('username', username);
  }

  // Метод для получения имени пользователя
  Future<String?> getUsername() async {
    return preferences.getString('username');
  }

  // Метод для сохранения электронной почты
  Future<void> setEmail(String email) async {
    await preferences.setString('email', email);
  }

  // Метод для получения электронной почты
  Future<String?> getEmail() async {
    return preferences.getString('email');
  }
}
