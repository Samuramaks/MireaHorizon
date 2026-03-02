// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/services/test_service.dart';
// import 'test_event.dart';
// import 'test_state.dart';

// class TestBloc extends Bloc<TestEvent, TestState> {
//   final TestService _testService;

//   TestBloc({required TestService testService})
//       : _testService = testService,
//         super(TestInitial()) {
//     on<FetchTests>(_onFetchTests);
//     on<FetchTestDetail>(_onFetchTestDetail);
//     on<RefreshTests>(_onRefreshTests);
//     // on<FetchTestForNewUser>(_onFetchTestForNewUser);
//     on<FetchTestForDirection>(_onFetchTestForDirection);
//     on<FetchTestForDifficultyLevel>(_onFetchTestForDifficultyLevel);
//     on<FetchDirections>(_onFetchDirections);
//     on<FetchTestForType>(_onFetchTestForType);
//     on<FetchTestForDirectionAndType>(_onFetchTestForDirectionAndType);
//   }

//   Future<void> _onFetchTests(FetchTests event, Emitter<TestState> emit) async {
//     try {
//       emit(TestLoading());
//       final tests = await _testService.getTests();
//       print(tests);
//       emit(TestsLoaded(tests));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onFetchTestDetail(
//       FetchTestDetail event, Emitter<TestState> emit) async {
//     try {
//       emit(TestLoading());
//       final test = await _testService.getTestById(event.testId);
//       emit(TestDetailLoaded(test));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onRefreshTests(
//       RefreshTests event, Emitter<TestState> emit) async {
//     try {
//       emit(TestLoading());
//       final tests = await _testService.getTests();
//       print(tests);
//       emit(TestsLoaded(tests));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   // Future<void> _onFetchTestForNewUser(
//   //     FetchTestForNewUser event, Emitter<TestState> emit) async {
//   //   try {
//   //     emit(TestLoading());
//   //     final test = await _testService.getTestForNewUser();
//   //     print(test);
//   //     emit(TestsLoaded(test));
//   //   } catch (e) {
//   //     emit(TestError(e.toString()));
//   //   }
//   // }

//   Future<void> _onFetchTestForDirection(
//       FetchTestForDirection event, Emitter<TestState> emit) async {
//     final test;
//     try {
//       emit(TestLoading());
//       if (event.direct == 'Total') {
//         test = await _testService.getTests();
//       } else {
//         test = await _testService.getTestForDirection(event.direct);
//       }

//       print(test);
//       emit(TestsLoaded(test));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onFetchTestForDifficultyLevel(
//       FetchTestForDifficultyLevel event, Emitter<TestState> emit) async {
//     final test;
//     try {
//       emit(TestLoading());
//       if (event.difficultyLevel == 'All') {
//         test = await _testService.getTests();
//       } else {
//         test =
//             await _testService.getTestForDifficultyLevel(event.difficultyLevel);
//       }

//       print(test);
//       emit(TestsLoaded(test));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onFetchDirections(
//     FetchDirections event,
//     Emitter<TestState> emit,
//   ) async {
//     try {
//       emit(TestLoading());
//       final directions =
//           await _testService.getDirectionsByInstitute(event.instituteId);
//       emit(DirectionsLoaded(directions));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onFetchTestForType(
//     FetchTestForType event,
//     Emitter<TestState> emit,
//   ) async {
//     try {
//       emit(TestLoading());
//       final tests = await _testService.getTestsByType(event.testType);
//       emit(TestsLoaded(tests));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   Future<void> _onFetchTestForDirectionAndType(
//     FetchTestForDirectionAndType event,
//     Emitter<TestState> emit,
//   ) async {
//     try {
//       emit(TestLoading());
//       final tests = await _testService.getTestsByDirectionAndType(
//         event.directionCode,
//         event.testType,
//       );
//       emit(TestsLoaded(tests));
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }
// }

// presentation/bloc/test_bloc/test_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/test_service.dart';
import 'test_event.dart';
import 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestService _testService;

  TestBloc({required TestService testService})
      : _testService = testService,
        super(TestInitial()) {
    print('🧱 TestBloc: инициализирован');

    on<FetchTests>(_onFetchTests);
    on<FetchTestDetail>(_onFetchTestDetail);
    on<RefreshTests>(_onRefreshTests);
    // on<FetchTestForNewUser>(_onFetchTestForNewUser);
    on<FetchTestForDirection>(_onFetchTestForDirection);
    on<FetchTestForDifficultyLevel>(_onFetchTestForDifficultyLevel);
    on<FetchDirections>(_onFetchDirections);
    on<FetchTestForType>(_onFetchTestForType);
    on<FetchTestForDirectionAndType>(_onFetchTestForDirectionAndType);
    on<FetchInstitutes>(_onFetchInstitutes);
    on<FetchDirectionsForInstitute>(_onFetchDirectionsForInstitute);
    on<FetchTestsForDirectionCode>(_onFetchTestsForDirectionCode);
  }

  Future<void> _onFetchTests(FetchTests event, Emitter<TestState> emit) async {
    print('🎯 TestBloc: получено событие FetchTests');
    try {
      emit(TestLoading());
      print('   📡 Запрос к API: ${_testService.baseUrl}');

      final tests = await _testService.getTests();
      print('   ✅ Получено тестов: ${tests.length}');
      print(
          '   📦 Пример: ${tests.isNotEmpty ? tests.first.nameTest : "нет данных"}');

      emit(TestsLoaded(tests, isFiltered: false));
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTests: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestDetail(
      FetchTestDetail event, Emitter<TestState> emit) async {
    print('🎯 TestBloc: получено событие FetchTestDetail');
    print('   📦 event.testId=${event.testId}');
    try {
      emit(TestLoading());
      print('   📡 Запрос к API: ${_testService.baseUrl}/${event.testId}');

      final test = await _testService.getTestById(event.testId);
      print('   ✅ Получен тест: ${test.nameTest}');

      emit(TestDetailLoaded(test));
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTestDetail: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onRefreshTests(
      RefreshTests event, Emitter<TestState> emit) async {
    print('🎯 TestBloc: получено событие RefreshTests');
    try {
      emit(TestLoading());
      print('   📡 Запрос к API: ${_testService.baseUrl}');

      final tests = await _testService.getTests();
      print('   ✅ Получено тестов: ${tests.length}');

      emit(TestsLoaded(tests));
    } catch (e) {
      print('   ❌ Ошибка в _onRefreshTests: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForDirection(
      FetchTestForDirection event, Emitter<TestState> emit) async {
    print('🎯 TestBloc: получено событие FetchTestForDirection');
    print('   📦 event.direct="${event.direct}"');

    try {
      emit(TestLoading());

      if (event.direct == 'Total') {
        print('   🔀 direct="Total" → вызываем getTests()');
        final tests = await _testService.getTests();
        print('   ✅ Получено тестов: ${tests.length}');
        emit(TestsLoaded(tests, isFiltered: true));
      } else {
        print(
            '   📡 Запрос к API: ${_testService.baseUrl}/find/name?nameTest=${event.direct}');
        final tests = await _testService.getTestsByDirection(event.direct);
        print('   ✅ Получено тестов: ${tests.length}');
        emit(TestsLoaded(tests));
      }
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTestForDirection: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForDifficultyLevel(
      FetchTestForDifficultyLevel event, Emitter<TestState> emit) async {
    print('🎯 TestBloc: получено событие FetchTestForDifficultyLevel');
    print('   📦 event.difficultyLevel="${event.difficultyLevel}"');

    try {
      emit(TestLoading());

      if (event.difficultyLevel == 'All') {
        print('   🔀 difficultyLevel="All" → вызываем getTests()');
        final tests = await _testService.getTests();
        print('   ✅ Получено тестов: ${tests.length}');
        emit(TestsLoaded(tests));
      } else {
        print(
            '   📡 Запрос к API: ${_testService.baseUrl}/find/level?difficultyLevel=${event.difficultyLevel}');
        final tests =
            await _testService.getTestForDifficultyLevel(event.difficultyLevel);
        print('   ✅ Получено тестов: ${tests.length}');
        emit(TestsLoaded(tests));
      }
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTestForDifficultyLevel: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchDirections(
    FetchDirections event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchDirections');
    print('   📦 event.instituteId=${event.instituteId}');

    try {
      emit(TestLoading());
      print(
          '   📡 Запрос к API: ${_testService.baseUrl}/directions/by-institute/${event.instituteId}');

      final directions =
          await _testService.getDirectionsByInstitute(event.instituteId);
      print('   ✅ Получено направлений: ${directions.length}');

      emit(DirectionsLoaded(directions));
    } catch (e) {
      print('   ❌ Ошибка в _onFetchDirections: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForType(
    FetchTestForType event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchTestForType');
    print('   📦 event.testType="${event.testType}"');
    final tests;

    try {
      emit(TestLoading());

      if (event.testType == 'Total') {
        print('   🔀 testType="Total" → вызываем getTests()');
        tests = await _testService.getTests();
        print('   ✅ Получено тестов: ${tests.length}');
      } else {
        print(
            '   📡 Запрос к API: ${_testService.baseUrl}/by-type/${event.testType}');
        tests = await _testService.getTestsByType(event.testType);
        print('   ✅ Получено тестов: ${tests.length}');
      }

      emit(TestsLoaded(tests, isFiltered: event.testType != 'Total'));
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTestForType: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForDirectionAndType(
    FetchTestForDirectionAndType event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchTestForDirectionAndType');
    print(
        '   📦 directionCode="${event.directionCode}", testType="${event.testType}"');

    final tests;

    try {
      emit(TestLoading());

      if (event.directionCode == 'Total' && event.testType == 'Total') {
        print('   🔀 Оба "Total" → вызываем getTests()');
        tests = await _testService.getTests();
        print('   ✅ Получено тестов: ${tests.length}');
      } else if (event.directionCode == 'Total') {
        print(
            '   🔀 direction="Total" → вызываем getTestsByType(${event.testType})');
        tests = await _testService.getTestsByType(event.testType);
        print('   ✅ Получено тестов: ${tests.length}');
      } else if (event.testType == 'Total') {
        print(
            '   🔀 type="Total" → вызываем getTestsByDirection(${event.directionCode})');
        tests = await _testService.getTestsByDirection(event.directionCode);
        print('   ✅ Получено тестов: ${tests.length}');
      } else {
        print(
            '   📡 Запрос к API: ${_testService.baseUrl}/by-direction/${event.directionCode}/by-type/${event.testType}');
        tests = await _testService.getTestsByDirectionAndType(
          event.directionCode,
          event.testType,
        );
        print('   ✅ Получено тестов: ${tests.length}');
      }

      emit(TestsLoaded(tests, isFiltered: true));
    } catch (e) {
      print('   ❌ Ошибка в _onFetchTestForDirectionAndType: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchInstitutes(
    FetchInstitutes event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchInstitutes');
    try {
      emit(TestLoading());
      final institutes = await _testService.getAllInstitutes();
      print('✅ Загружено институтов: ${institutes.length}');
      emit(InstitutesLoaded(institutes));
    } catch (e) {
      print('❌ Ошибка в _onFetchInstitutes: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchDirectionsForInstitute(
    FetchDirectionsForInstitute event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchDirectionsForInstitute');
    print('📦 event.instituteId=${event.instituteId}');
    try {
      emit(TestLoading());
      final directions =
          await _testService.getDirectionsByInstitute(event.instituteId);
      print('✅ Загружено направлений: ${directions.length}');
      emit(DirectionsForInstituteLoaded(directions));
    } catch (e) {
      print('❌ Ошибка в _onFetchDirectionsForInstitute: $e');
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestsForDirectionCode(
    FetchTestsForDirectionCode event,
    Emitter<TestState> emit,
  ) async {
    print('🎯 TestBloc: получено событие FetchTestsForDirectionCode');
    print('📦 event.directionCode="${event.directionCode}"');
    try {
      emit(TestLoading());
      final tests = await _testService.getTestsByDirection(event.directionCode);
      print('✅ Загружено тестов: ${tests.length}');
      emit(TestsLoaded(tests));
    } catch (e) {
      print('❌ Ошибка в _onFetchTestsForDirectionCode: $e');
      emit(TestError(e.toString()));
    }
  }
}
