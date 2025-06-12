import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  // Метод для установки флага нового пользователя
  Future<void> setNewUserFlag(bool isNewUser) async {
    await setBoolLocalData('isNewUser', isNewUser);
  }

  // Метод для получения флага нового пользователя
  Future<bool> isNewUser() async {
    bool? isNewUser = await getBoolLocalData('isNewUser');
    return isNewUser ??
        true; // Если флаг не установлен, считаем, что это новый пользователь
  }

  // Метод для сохранения результата теста
  Future<void> saveTestResult(String testName, int coins, int correctAnswers,
      int totalQuestions) async {
    List<String> results = preferences.getStringList('test_results') ?? [];

    // Создаем новый результат
    final newResult = {
      'test_name': testName,
      'coins': coins,
      'correct_answers': correctAnswers,
      'total_questions': totalQuestions,
    };
    results.add(jsonEncode(newResult));

    // Обновляем общее количество монет
    final currentCoins = preferences.getInt('total_coins') ?? 0;
    await preferences.setInt('total_coins', currentCoins + coins);

    // Сохраняем результаты
    await preferences.setStringList('test_results', results);
  }

  // Метод для получения всех результатов тестов
  Future<List<Map<String, dynamic>>> getTestResults() async {
    final results = preferences.getStringList('test_results') ?? [];
    return results.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  // Метод для получения общего количества монет
  Future<int> getTotalCoins() async {
    return preferences.getInt('total_coins') ?? 0;
  }

  // Метод для очистки результатов тестов
  Future<void> clearTestResults() async {
    await preferences.remove('test_results');
    await preferences.remove('total_coins');
  }
}
