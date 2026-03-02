import 'package:equatable/equatable.dart';
import 'package:mirea_horizon/data/models/tests/institute_model.dart';
import '../../../data/models/tests/direction.dart';
import '../../../data/models/tests/test_models.dart';

abstract class TestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestsLoaded extends TestState {
  final List<Test> tests;
  final bool isFiltered;

  TestsLoaded(this.tests, {this.isFiltered = false});

  @override
  List<Object?> get props => [tests, isFiltered];
}

class TestDetailLoaded extends TestState {
  final Test test;

  TestDetailLoaded(this.test);

  @override
  List<Object?> get props => [test];
}

class TestError extends TestState {
  final String message;

  TestError(this.message);

  @override
  List<Object?> get props => [message];
}

class DirectionsLoaded extends TestState {
  final List<Direction> directions;
  DirectionsLoaded(this.directions);

  @override
  List<Object?> get props => [directions];
}

class InstitutesLoaded extends TestState {
  final List<Institute> institutes;
  InstitutesLoaded(this.institutes);

  @override
  List<Object?> get props => [institutes];
}

// 🔥 Состояние: направления загружены
class DirectionsForInstituteLoaded extends TestState {
  final List<Direction> directions;
  DirectionsForInstituteLoaded(this.directions);

  @override
  List<Object?> get props => [directions];
}
