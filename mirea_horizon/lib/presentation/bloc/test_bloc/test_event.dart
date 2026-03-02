import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTests extends TestEvent {}

// class FetchTestForNewUser extends TestEvent {}

class FetchTestForDirection extends TestEvent {
  final String direct;

  FetchTestForDirection(this.direct);
}

class FetchTestForDifficultyLevel extends TestEvent {
  final String difficultyLevel;

  FetchTestForDifficultyLevel(this.difficultyLevel);

  @override
  List<Object> get props => [difficultyLevel];
}

class FetchTestDetail extends TestEvent {
  final int testId;

  FetchTestDetail(this.testId);

  @override
  List<Object?> get props => [testId];
}

class RefreshTests extends TestEvent {}

class FetchDirections extends TestEvent {
  final int instituteId;
  FetchDirections(this.instituteId);
}

class FetchTestForType extends TestEvent {
  final String testType;
  FetchTestForType(this.testType);
}

// 🔥 Загрузка тестов по направлению + типу
class FetchTestForDirectionAndType extends TestEvent {
  final String directionCode;
  final String testType;

  FetchTestForDirectionAndType({
    required this.directionCode,
    required this.testType,
  });
}

class FetchInstitutes extends TestEvent {}

// 🔥 Новое событие: загрузка направлений для института
class FetchDirectionsForInstitute extends TestEvent {
  final int instituteId;
  FetchDirectionsForInstitute(this.instituteId);

  @override
  List<Object?> get props => [instituteId];
}

// 🔥 Новое событие: загрузка тестов для направления (по коду)
class FetchTestsForDirectionCode extends TestEvent {
  final String directionCode;
  FetchTestsForDirectionCode(this.directionCode);

  @override
  List<Object?> get props => [directionCode];
}
