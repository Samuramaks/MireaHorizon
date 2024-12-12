import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/test_models.dart';

class TestService {
  final String baseUrl;

  TestService({required this.baseUrl});

  Future<List<Test>> getTests() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((json) => Test.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tests');
      }
    } catch (e) {
      throw Exception('Error fetching tests: $e');
    }
  }

  Future<Test> getTestById(int id) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}/$id'));

      if (response.statusCode == 200) {
        return Test.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load test');
    } catch (e) {
      throw Exception('Error fetching test: $e');
    }
  }
}
