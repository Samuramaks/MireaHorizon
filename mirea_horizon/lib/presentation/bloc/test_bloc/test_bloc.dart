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
    // on<FetchTestDetail>(_onFetchTestDetail);
  }

  Future<void> _onFetchTests(FetchTests event, Emitter<TestState> emit) async {
    try {
      emit(TestLoading());
      final tests = await _testService.getTests();
      print('{iy}');
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
}
