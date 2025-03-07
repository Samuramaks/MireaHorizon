import 'package:mirea_horizon/data/models/result/result_model.dart';

abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<Result> result;

  ProgressLoaded(this.result);
}

class ProgressError extends ProgressState {
  final String message;

  ProgressError(this.message);
}
