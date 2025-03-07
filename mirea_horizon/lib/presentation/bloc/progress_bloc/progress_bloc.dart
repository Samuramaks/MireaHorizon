import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/data/repositories/result/result_repository.dart';

import 'progress_event.dart';
import 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final ResultRepository _resultRepository = ResultRepository();
  final User? user = FirebaseAuth.instance.currentUser;
  ProgressBloc() : super(ProgressInitial()) {
    on<FetchProgress>(_onFetchProgress);
    on<RefreshProgress>(_onRefreshProgress);
  }

  Future<void> _onFetchProgress(
      FetchProgress event, Emitter<ProgressState> emit) async {
    try {
      emit(ProgressLoading());
      print('fetch');
      final result = await _resultRepository.getTestResults(user!.email!);
      emit(ProgressLoaded(result));
    } catch (e) {
      emit(ProgressError(e.toString()));
      print('error');
    }
  }

  Future<void> _onRefreshProgress(
      RefreshProgress event, Emitter<ProgressState> emit) async {
    try {
      final result = await _resultRepository.getTestResults(user!.email!);
      emit(ProgressLoaded(result));
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }
}
