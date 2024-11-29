part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationLoadEvent extends NavigationEvent {}

class NavigationSelectTabEvent extends NavigationEvent {
  final int selectedTab;

  const NavigationSelectTabEvent(this.selectedTab);
}
