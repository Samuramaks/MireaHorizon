import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_event.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_state.dart';

import '../../../data/services/collab/collab_service.dart';

class CollabBloc extends Bloc<CollabEvent, CollabState> {
  final _directionService = DirectionService();
  CollabBloc() : super(CollabInitial()) {
    on<FetchCollab>(_onFetchCollab);
    on<RefreshCollab>(_onRefreshCollab);
  }

  Future<void> _onFetchCollab(
      FetchCollab event, Emitter<CollabState> emit) async {
    try {
      emit(CollabLoading());
      print('fetch');
      final result = await _directionService.fetchAllDirections();
      emit(CollabLoaded(result));
    } catch (e) {
      emit(CollabError(e.toString()));
      print('error');
    }
  }

  Future<void> _onRefreshCollab(
      RefreshCollab event, Emitter<CollabState> emit) async {
    try {
      final result = await _directionService.fetchAllDirections();
      emit(CollabLoaded(result));
    } catch (e) {
      emit(CollabError(e.toString()));
    }
  }
}
