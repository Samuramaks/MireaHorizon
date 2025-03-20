import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/result/result_model.dart';

class ResultRepository {
  final String baseUrl = 'http://127.0.0.1:8080';

  ResultRepository();

  Future<void> submitTestResult(Result result) async {
    // Формируем URL с параметрами
    final url = Uri.parse(
        '$baseUrl/api/test/results?email=${result.email}&coins=${result.coins}&testName=${result.testName}&correctAnswers=${result.correctAnswers}&totalQuestions=${result.totalQuestions}');

    // Отправляем POST-запрос
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({}), // Тело запроса можно оставить пустым
    );

    // Обработка ответа
    if (response.statusCode == 200) {
      print('Результат теста успешно отправлен');
    } else {
      print('Ошибка при отправке результата теста: ${response.body}');
    }
  }

  Future<List<Result>> getTestResults(String email) async {
    final url = Uri.parse('$baseUrl/api/test/get/results?email=$email');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print('JSon: $jsonResponse');
      return jsonResponse.map((result) => Result.fromJson(result)).toList();
    } else {
      throw Exception(
          'Ошибка при получении результатов тестов: ${response.body}');
    }
  }
}
