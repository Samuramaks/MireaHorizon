part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int currentIndex;
  final bool isLoading;
  final bool isOpen;

  const NavigationState(this.currentIndex, this.isLoading, this.isOpen);

  NavigationState copyWith({
    int? currentIndex,
    bool isLoading = false,
    bool? isOpen,
  }) {
    return NavigationState(
      currentIndex = currentIndex ?? this.currentIndex,
      isLoading = isLoading,
      isOpen = isOpen ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [currentIndex, isLoading, isOpen];
}
