import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/test_service.dart';
import 'test_event.dart';
import 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestService _testService;

  TestBloc({required TestService testService})
      : _testService = testService,
        super(TestInitial()) {
    on<FetchTests>(_onFetchTests);
    on<FetchTestDetail>(_onFetchTestDetail);
    on<RefreshTests>(_onRefreshTests);
    on<FetchTestForNewUser>(_onFetchTestForNewUser);
    on<FetchTestForDirection>(_onFetchTestForDirection);
    on<FetchTestForDifficultyLevel>(_onFetchTestForDifficultyLevel);
  }

  Future<void> _onFetchTests(FetchTests event, Emitter<TestState> emit) async {
    try {
      emit(TestLoading());
      final tests = await _testService.getTests();
      print(tests);
      emit(TestsLoaded(tests));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestDetail(
      FetchTestDetail event, Emitter<TestState> emit) async {
    try {
      emit(TestLoading());
      final test = await _testService.getTestById(event.testId);
      emit(TestDetailLoaded(test));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onRefreshTests(
      RefreshTests event, Emitter<TestState> emit) async {
    try {
      emit(TestLoading());
      final tests = await _testService.getTests();
      print(tests);
      emit(TestsLoaded(tests));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForNewUser(
      FetchTestForNewUser event, Emitter<TestState> emit) async {
    try {
      emit(TestLoading());
      final test = await _testService.getTestForNewUser();
      print(test);
      emit(TestsLoaded(test));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForDirection(
      FetchTestForDirection event, Emitter<TestState> emit) async {
    final test;
    try {
      emit(TestLoading());
      if (event.direct == 'Total') {
        test = await _testService.getTests();
      } else {
        test = await _testService.getTestForDirection(event.direct);
      }

      print(test);
      emit(TestsLoaded(test));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }

  Future<void> _onFetchTestForDifficultyLevel(
      FetchTestForDifficultyLevel event, Emitter<TestState> emit) async {
    final test;
    try {
      emit(TestLoading());
      if (event.difficultyLevel == 'All') {
        test = await _testService.getTests();
      } else {
        test =
            await _testService.getTestForDifficultyLevel(event.difficultyLevel);
      }

      print(test);
      emit(TestsLoaded(test));
    } catch (e) {
      emit(TestError(e.toString()));
    }
  }
}
