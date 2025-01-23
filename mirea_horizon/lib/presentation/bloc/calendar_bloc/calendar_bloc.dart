import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_state.dart';

import '../../../data/services/calendar/calendar_service.dart';
import 'calendar_event.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarService _calendarService = CalendarService();
  CalendarBloc() : super(CalendarInitial()) {
    on<FetchCalendar>(_onFetchCalendar);
    on<RefreshCalendar>(_onRefreshCalendar);
  }

  Future<void> _onFetchCalendar(
      FetchCalendar event, Emitter<CalendarState> emit) async {
    try {
      emit(CalendarLoading());
      print('fetch');
      final calendar = await _calendarService.fetchCalendar();
      emit(CalendarLoaded(calendar));
    } catch (e) {
      emit(CalendarError(e.toString()));
      print('error');
    }
  }

  Future<void> _onRefreshCalendar(
      RefreshCalendar event, Emitter<CalendarState> emit) async {
    try {
      final calendar = await _calendarService.fetchCalendar();
      emit(CalendarLoaded(calendar));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }
}
