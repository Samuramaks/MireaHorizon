import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mirea_horizon/data/dao/user/user_dao.dart';
import 'package:mirea_horizon/data/models/user/user_model.dart';

class UserRepository implements UserDao {
  final String baseUrl = 'http://127.0.0.1:8080';

  UserRepository();

  @override
  Future<void> postUser(UserCustom user) async {
    final url = Uri.parse('$baseUrl/api/user');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('Пользователь добавлен');
    } else {
      print('Ошибка добавления: ${response.body}');
    }
  }

  Future<int?> getUserCoins(String email) async {
    final Uri url = Uri.parse('$baseUrl/api/user/coins?email=$email');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Если запрос успешен, парсим количество монет из ответа
        return jsonDecode(
            response.body); // Предполагаем, что ответ - это просто число
      } else if (response.statusCode == 404) {
        print('Пользователь не найден');
        return 0; // Возвращаем null, если пользователь не найден
      } else {
        print('Ошибка: ${response.statusCode} - ${response.body}');
        return 0; // Возвращаем null в случае других ошибок
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
      return 0; // Возвращаем null в случае исключения
    }
  }
}
