import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Импортируем intl
import 'package:intl/date_symbol_data_local.dart'; // Для локализации

import '../../../data/models/calendar/calendar_model.dart';
import '../widgets/custom_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Даты для фокуса и выбора
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  final DateTime _firstDay = DateTime(1900, 1, 1); // Первый день
  final DateTime _lastDay = DateTime(2100, 12, 31); // Последний день
  Map<DateTime, List<Event>> eventsMap = {};
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru_RU', null); // Инициализация локализации
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForDay(_selectedDay);
    });
  }

  void _onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return eventsMap[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Календарь',
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CalendarLoaded) {
            eventsMap.clear();
            for (var event in state.event) {
              if (!eventsMap.containsKey(event.date)) {
                eventsMap[event.date] = [];
              }

              eventsMap[event.date]!.add(event);
            }
            // Фильтруем события для выбранного дня
            _selectedEvents.value = state.event
                .where((event) => isSameDay(event.date, _selectedDay))
                .toList();

            return Center(
              child: Column(
                children: [
                  TableCalendar(
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    locale: 'ru-RU',
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: _onDaySelected,
                    onPageChanged: _onPageChanged,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    eventLoader: _getEventsForDay,
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (BuildContext context, date, events) {
                        if (events.isEmpty) return SizedBox();
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    // height: 7,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ));
                            });
                      },
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    title: Text(value[index]
                                        .name), // Отображаем название события
                                    subtitle: Text(DateFormat('yyyy-MM-dd')
                                        .format(value[index]
                                            .date)), // Отображаем дату события
                                  ),
                                );
                              });
                        }),
                  ),
                ],
              ),
            );
          } else if (state is CalendarError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Нет доступных событий'));
        },
      ),
    );
  }
}
