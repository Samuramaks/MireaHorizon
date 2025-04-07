import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_event.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_state.dart';
import 'package:mirea_horizon/presentation/features/widgets/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  late final bool _isVerifed;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru_RU', null); // Инициализация локализации
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    _isVerifed = FirebaseAuth.instance.currentUser!.emailVerified;
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

  Future<void> _refreshData(BuildContext context) async {
    BlocProvider.of<CalendarBloc>(context).add(RefreshCalendar());
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        nameAppBar: 'Календарь',
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Text(
                  _getContactionsDay(_focusedDay.day),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Column(
                  children: [
                    Text(_getWeekdayByNumber(_focusedDay.weekday)),
                    Text(
                        "${_getMonthByNumber(_focusedDay.month)} ${_focusedDay.year}"),
                  ],
                )
              ],
            )),
        body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          backgroundColor: Colors.white,
          child: BlocBuilder<CalendarBloc, CalendarState>(
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
                        calendarStyle: CalendarStyle(
                            selectedDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle)),
                        calendarFormat: CalendarFormat.week,
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        locale: 'ru-RU',
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: _onDaySelected,
                        onPageChanged: _onPageChanged,
                        firstDay: _firstDay,
                        lastDay: _lastDay,
                        eventLoader: _getEventsForDay,
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (BuildContext context, date, events) {
                            if (events.isEmpty) return const SizedBox();
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.all(1),
                                      child: Container(
                                        width: 5,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueAccent,
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
                                    return GestureDetector(
                                      onTap: () {
                                        _isVerifed
                                            ? MyUtils.launchInBrowser(
                                                Uri.parse(value[index].url))
                                            : Container();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ListTile(
                                            title: Text(value[index]
                                                .name), // Отображаем название события
                                            subtitle: Text(
                                                '${value[index].description}\n${value[index].typeInfo}'),
                                            leading: Image.network(
                                                value[index].imageUrl)),
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
        ));
  }

  String _getContactionsDay(int day) {
    return day > 10 ? day.toString() : '0$day';
  }

  String _getWeekdayByNumber(int number) {
    var mapWeekday = {
      1: "Пн",
      2: "Вт",
      3: "Ср",
      4: "Чт",
      5: "Пт",
      6: "Сб",
      7: "Вс",
    };

    return mapWeekday[number] ?? 'Некорректный номер дня';
  }

  String _getMonthByNumber(int number) {
    Map<int, String> monthsOfYear = {
      1: 'Января', // Январь
      2: 'Февраля', // Февраль
      3: 'Марта', // Март
      4: 'Апреля', // Апрель
      5: 'Мая', // Май
      6: 'Июня', // Июнь
      7: 'Июля', // Июль
      8: 'Августа', // Август
      9: 'Сентября', // Сентябрь
      10: 'Октября', // ОктябрьT
      11: 'Ноября', // Ноябрь
      12: 'Декабря', // Декабрь
    };
    return monthsOfYear[number] ?? 'Некорректный номер месяца';
  }
}
