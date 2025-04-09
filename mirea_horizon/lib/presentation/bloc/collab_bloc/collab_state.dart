import 'package:mirea_horizon/data/models/collaborators/collab_item.dart';

abstract class CollabState {}

class CollabInitial extends CollabState {}

class CollabLoading extends CollabState {}

class CollabLoaded extends CollabState {
  final List<Direction> direct;

  CollabLoaded(this.direct);
}

class CollabError extends CollabState {
  final String message;

  CollabError(this.message);
}
