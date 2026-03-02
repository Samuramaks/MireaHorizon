import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {}

class RefreshNews extends NewsEvent {}

class LoadNewsByUrl extends NewsEvent {
  final String url;
  LoadNewsByUrl(this.url);
}
