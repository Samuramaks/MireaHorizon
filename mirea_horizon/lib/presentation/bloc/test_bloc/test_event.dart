import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTests extends TestEvent {}

class FetchTestDetail extends TestEvent {
  final int testId;

  FetchTestDetail(this.testId);

  @override
  List<Object?> get props => [testId];
}
