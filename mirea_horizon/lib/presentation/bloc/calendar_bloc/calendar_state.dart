import 'package:mirea_horizon/data/models/calendar/calendar_model.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<Event> event;

  CalendarLoaded(this.event);
}

class CalendarError extends CalendarState {
  final String message;

  CalendarError(this.message);
}
