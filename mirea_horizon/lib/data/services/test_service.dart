// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:mirea_horizon/data/models/tests/direction.dart';
// import '../models/tests/institute_model.dart';
// import '../models/tests/test_models.dart';

// class TestService {
//   final String baseUrl;

//   TestService({required this.baseUrl});

//   // Future<List<Test>> getTests() async {
//   //   try {
//   //     final response = await http.get(Uri.parse(baseUrl));

//   //     if (response.statusCode == 200) {
//   //       final List<dynamic> jsonData =
//   //           json.decode(utf8.decode(response.bodyBytes));
//   //       // Преобразуем JSON в список тестов
//   //       List<Test> tests = jsonData.map((json) => Test.fromJson(json)).toList();

//   //       // Фильтруем тесты, исключая те, у которых уровень NoLevel
//   //       tests =
//   //           tests.where((test) => test.difficultyLevel != 'NoLevel').toList();

//   //       return tests;
//   //     } else {
//   //       throw Exception('Failed to load tests');
//   //     }
//   //   } catch (e) {
//   //     throw Exception('Error fetching tests: $e');
//   //   }
//   // }

//   Future<List<Test>> getTests() async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl));

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData =
//             json.decode(utf8.decode(response.bodyBytes));
//         List<Test> tests = jsonData.map((json) => Test.fromJson(json)).toList();

//         // 🔥 Всегда фильтруем NoLevel (кроме специального метода для новых пользователей)
//         tests =
//             tests.where((test) => test.difficultyLevel != 'NoLevel').toList();

//         return tests;
//       }
//       throw Exception('Failed to load tests');
//     } catch (e) {
//       throw Exception('Error fetching tests: $e');
//     }
//   }

//   Future<Test> getTestById(int id) async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/$id'));

//       if (response.statusCode == 200) {
//         return Test.fromJson(json.decode(response.body));
//       }
//       throw Exception('Failed to load test');
//     } catch (e) {
//       throw Exception('Error fetching test: $e');
//     }
//   }

//   Future<List<Test>> getTestForNewUser() async {
//     try {
//       final response = await http
//           .get(Uri.parse('$baseUrl/find/level?difficultyLevel=NoLevel'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData =
//             json.decode(utf8.decode(response.bodyBytes));
//         return jsonData.map((json) => Test.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load tests');
//       }
//     } catch (e) {
//       throw Exception('Error fetching test: $e');
//     }
//   }

//   Future<List<Test>> getTestForDirection(String direct) async {
//     try {
//       final response =
//           await http.get(Uri.parse('$baseUrl/find/name?nameTest=$direct'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData =
//             json.decode(utf8.decode(response.bodyBytes));
//         return jsonData.map((json) => Test.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load tests');
//       }
//     } catch (e) {
//       throw Exception('Error fetching test: $e');
//     }
//   }

//   Future<List<Test>> getTestForDifficultyLevel(String level) async {
//     try {
//       final response = await http
//           .get(Uri.parse('$baseUrl/find/level?difficultyLevel=$level'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData =
//             json.decode(utf8.decode(response.bodyBytes));
//         return jsonData.map((json) => Test.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load tests');
//       }
//     } catch (e) {
//       throw Exception('Error fetching test: $e');
//     }
//   }

//   // Загружает все направления с тестами для института
//   Future<List<Direction>> getDirectionsByInstitute(int instituteId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/directions/by-institute/$instituteId'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Direction.fromJson(json)).toList();
//       }
//       throw Exception('Failed to load directions');
//     } catch (e) {
//       throw Exception('Error fetching directions: $e');
//     }
//   }

//   /// Загружает тесты по коду направления
//   Future<List<Test>> getTestsByDirection(String directionCode) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/by-direction/$directionCode'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Test.fromJson(json)).toList();
//       }
//       throw Exception('Failed to load tests');
//     } catch (e) {
//       throw Exception('Error fetching tests: $e');
//     }
//   }

//   Future<List<Institute>> getAllInstitutes() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/institutes'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Institute.fromJson(json)).toList();
//       }
//       throw Exception('Failed to load institutes: ${response.statusCode}');
//     } catch (e) {
//       throw Exception('Error fetching institutes: $e');
//     }
//   }

//   Future<List<Test>> getTestsByType(String testType) async {
//     // try {
//     //   final response = await http.get(
//     //     Uri.parse('$baseUrl/by-type/$testType'),
//     //   );
//     //   if (response.statusCode == 200) {
//     //     final List<dynamic> jsonData = json.decode(response.body);
//     //     return jsonData.map((json) => Test.fromJson(json)).toList();
//     //   }
//     //   throw Exception('Failed to load tests by type');
//     // } catch (e) {
//     //   throw Exception('Error fetching tests by type: $e');
//     // }

//     if (testType == 'Total') return getTests();
//     final response = await http.get(Uri.parse('$baseUrl/by-type/$testType'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((json) => Test.fromJson(json)).toList();
//     }
//     throw Exception('Failed to load tests by type');
//   }

//   Future<List<Test>> getTestsByDirectionAndType(
//     String directionCode,
//     String testType,
//   ) async {
//     if (directionCode == 'Total' && testType == 'Total') return getTests();
//     if (directionCode == 'Total') return getTestsByType(testType);
//     if (testType == 'Total') {
//       final response =
//           await http.get(Uri.parse('$baseUrl/by-direction/$directionCode'));
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Test.fromJson(json)).toList();
//       }
//       throw Exception('Failed to load tests by direction');
//     }
//     final response = await http.get(
//         Uri.parse('$baseUrl/by-direction/$directionCode/by-type/$testType'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((json) => Test.fromJson(json)).toList();
//     }
//     throw Exception('Failed to load tests');
//   }
// }

// data/services/test_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mirea_horizon/data/models/tests/direction.dart';
import '../models/tests/institute_model.dart';
import '../models/tests/test_models.dart';

class TestService {
  final String baseUrl;

  TestService({required this.baseUrl});

  Future<List<Test>> getTests() async {
    print('🌐 TestService: getTests()');
    print('   📡 GET ${baseUrl}');

    try {
      final response = await http.get(Uri.parse(baseUrl));
      print(
          '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');

        List<Test> tests = jsonData.map((json) => Test.fromJson(json)).toList();
        tests =
            tests.where((test) => test.difficultyLevel != 'NoLevel').toList();
        print('   🔥 Отфильтровано NoLevel: осталось ${tests.length} тестов');

        return tests;
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests');
    } catch (e) {
      print('   💥 Исключение в getTests: $e');
      throw Exception('Error fetching tests: $e');
    }
  }

  Future<Test> getTestById(int id) async {
    print('🌐 TestService: getTestById($id)');
    print('   📡 GET ${baseUrl}/$id');

    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      print('   📦 Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final test = Test.fromJson(json.decode(response.body));
        print('   ✅ Распарсен тест: ${test.nameTest}');
        return test;
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load test');
    } catch (e) {
      print('   💥 Исключение в getTestById: $e');
      throw Exception('Error fetching test: $e');
    }
  }

  Future<List<Test>> getTestForNewUser() async {
    print('🌐 TestService: getTestForNewUser()');
    final url = '$baseUrl/find/level?difficultyLevel=NoLevel';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('   📦 Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests');
    } catch (e) {
      print('   💥 Исключение в getTestForNewUser: $e');
      throw Exception('Error fetching test: $e');
    }
  }

  // Future<List<Test>> getTestForDirection(String direct) async {
  //   print('🌐 TestService: getTestForDirection("$direct")');
  //   final url = '$baseUrl/find/name?nameTest=$direct';
  //   print('   📡 GET $url');

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     print(
  //         '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData =
  //           json.decode(utf8.decode(response.bodyBytes));
  //       print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
  //       return jsonData.map((json) => Test.fromJson(json)).toList();
  //     }
  //     print('   ❌ HTTP ${response.statusCode}: ${response.body}');
  //     throw Exception('Failed to load tests');
  //   } catch (e) {
  //     print('   💥 Исключение в getTestForDirection: $e');
  //     throw Exception('Error fetching test: $e');
  //   }
  // }

  // ✅ СТАЛО (работает для кодов направлений):
  Future<List<Test>> getTestForDirection(String directionCode) async {
    print('🌐 TestService: getTestForDirection("$directionCode")');

    // 🔥 Если "Total" — возвращаем все тесты
    if (directionCode == 'Total') {
      print('   🔀 directionCode="Total" → вызываем getTests()');
      return getTests();
    }

    // 🔥 Иначе запрашиваем по направлению (без фильтрации по типу)
    final url = '$baseUrl/by-direction/$directionCode';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print(
          '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests by direction');
    } catch (e) {
      print('   💥 Исключение в getTestForDirection: $e');
      throw Exception('Error fetching tests: $e');
    }
  }

  Future<List<Test>> getTestForDifficultyLevel(String level) async {
    print('🌐 TestService: getTestForDifficultyLevel("$level")');
    final url = '$baseUrl/find/level?difficultyLevel=$level';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('   📦 Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests');
    } catch (e) {
      print('   💥 Исключение в getTestForDifficultyLevel: $e');
      throw Exception('Error fetching test: $e');
    }
  }

  Future<List<Direction>> getDirectionsByInstitute(int instituteId) async {
    print('🌐 TestService: getDirectionsByInstitute($instituteId)');
    final url = '$baseUrl/directions/by-institute/$instituteId';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('   📦 Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено направлений: ${jsonData.length}');
        return jsonData.map((json) => Direction.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load directions');
    } catch (e) {
      print('   💥 Исключение в getDirectionsByInstitute: $e');
      throw Exception('Error fetching directions: $e');
    }
  }

  Future<List<Test>> getTestsByDirection(String directionCode) async {
    print('🌐 TestService: getTestsByDirection("$directionCode")');
    final url = '$baseUrl/by-direction/$directionCode';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print(
          '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests');
    } catch (e) {
      print('   💥 Исключение в getTestsByDirection: $e');
      throw Exception('Error fetching tests: $e');
    }
  }

  Future<List<Institute>> getAllInstitutes() async {
    print('🌐 TestService: getAllInstitutes()');
    final url = '$baseUrl/institutes';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('   📦 Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено институтов: ${jsonData.length}');
        return jsonData.map((json) => Institute.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load institutes: ${response.statusCode}');
    } catch (e) {
      print('   💥 Исключение в getAllInstitutes: $e');
      throw Exception('Error fetching institutes: $e');
    }
  }

  Future<List<Test>> getTestsByType(String testType) async {
    print('🌐 TestService: getTestsByType("$testType")');

    if (testType == 'Total') {
      print('   🔀 testType="Total" → делегируем getTests()');
      return getTests();
    }

    final url = '$baseUrl/by-type/$testType';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print(
          '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests by type');
    } catch (e) {
      print('   💥 Исключение в getTestsByType: $e');
      throw Exception('Error fetching tests by type: $e');
    }
  }

  Future<List<Test>> getTestsByDirectionAndType(
    String directionCode,
    String testType,
  ) async {
    print(
        '🌐 TestService: getTestsByDirectionAndType(dir="$directionCode", type="$testType")');

    if (directionCode == 'Total' && testType == 'Total') {
      print('   🔀 Оба "Total" → делегируем getTests()');
      return getTests();
    }
    if (directionCode == 'Total') {
      print('   🔀 direction="Total" → делегируем getTestsByType($testType)');
      return getTestsByType(testType);
    }
    if (testType == 'Total') {
      print(
          '   🔀 type="Total" → делегируем getTestsByDirection($directionCode)');
      return getTestsByDirection(directionCode);
    }

    final url = '$baseUrl/by-direction/$directionCode/by-type/$testType';
    print('   📡 GET $url');

    try {
      final response = await http.get(Uri.parse(url));
      print(
          '   📦 Status: ${response.statusCode}, Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('   ✅ Распарсено JSON: ${jsonData.length} элементов');
        return jsonData.map((json) => Test.fromJson(json)).toList();
      }
      print('   ❌ HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load tests');
    } catch (e) {
      print('   💥 Исключение в getTestsByDirectionAndType: $e');
      throw Exception('Error fetching tests: $e');
    }
  }
}
