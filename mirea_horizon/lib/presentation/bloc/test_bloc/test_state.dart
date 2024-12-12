import 'package:equatable/equatable.dart';
import '../../../data/models/test_models.dart';

abstract class TestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestsLoaded extends TestState {
  final List<Test> tests;

  TestsLoaded(this.tests);

  @override
  List<Object?> get props => [tests];
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
