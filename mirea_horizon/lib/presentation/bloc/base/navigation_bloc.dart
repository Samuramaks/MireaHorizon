import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/settings.dart';
import '../../../data/repositories/local_data/local_data.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0, false, false)) {
    on<NavigationSelectTabEvent>(_onNavigationSelectTabEvent);
    on<NavigationLoadEvent>(_onNavigationLoadEvent);
  }

  final SPRepository _spLocalRepository = GetIt.instance<SPRepository>();

  _onNavigationSelectTabEvent(
      NavigationSelectTabEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(currentIndex: event.selectedTab));
  }

  _onNavigationLoadEvent(
      NavigationLoadEvent event, Emitter<NavigationState> emit) async {
    emit(state.copyWith(isLoading: true));
    final isOpen =
        await _spLocalRepository.getBoolLocalData(LocalKeys.openKey) ?? false;
    emit(state.copyWith(isLoading: isOpen));
  }
}
