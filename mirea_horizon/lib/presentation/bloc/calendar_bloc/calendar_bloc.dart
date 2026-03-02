import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/models/calendar/calendar_model.dart';
import 'package:mirea_horizon/data/services/user/user_direction_service.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_state.dart';

import '../../../data/services/calendar/calendar_service.dart';
import 'calendar_event.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarService _calendarService = CalendarService();
  final UserDirectionService _directionService =
      GetIt.instance<UserDirectionService>();

  CalendarBloc() : super(CalendarInitial()) {
    on<FetchCalendar>(_onFetchCalendar);
    on<RefreshCalendar>(_onRefreshCalendar);
    _directionService.addListener(() {
      add(RefreshCalendar());
    });
  }

  Future<void> _onFetchCalendar(
      FetchCalendar event, Emitter<CalendarState> emit) async {
    try {
      emit(CalendarLoading());
      print('fetch');
      final calendar = await _calendarService.fetchCalendar();
      final filteredEvents = _filterEventsByDirection(calendar);
      emit(CalendarLoaded(filteredEvents));
    } catch (e) {
      emit(CalendarError(e.toString()));
      print('error');
    }
  }

  Future<void> _onRefreshCalendar(
      RefreshCalendar event, Emitter<CalendarState> emit) async {
    try {
      final calendar = await _calendarService.fetchCalendar();
      final filteredEvents = _filterEventsByDirection(calendar);
      emit(CalendarLoaded(filteredEvents));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  List<Event> _filterEventsByDirection(List<Event> events) {
    final selectedDirection = _directionService.selectedDirection;

    // Если направление не выбрано или "Общее" — показываем всё
    if (selectedDirection == null || selectedDirection == 'Total') {
      return events;
    }

    // Карта соответствия: направление → допустимые type_info из вашей БД
    final Map<String, List<String>> directionMap = {
      'Programmer': [
        'Backend',
        'Frontend',
        'Mobile',
        'GameDev',
        'QA',
      ],
      'Designer Education': [
        'UI/UX',
        'Дизайн',
      ],
      'Analyst Education': [
        'AI',
        'Аналитика',
        'Менеджмент',
        'Инфраструктура',
        'Безопасность',
        'HR',
        'Железо',
      ],
    };

    final allowedTypes = directionMap[selectedDirection] ?? [];

    return events.where((event) {
      return allowedTypes.contains(event.typeInfo);
    }).toList();
  }

  @override
  Future<void> close() {
    // 🔥 Очищаем listener при закрытии блока
    _directionService.removeListener(() {
      add(RefreshCalendar());
    });
    return super.close();
  }
}
