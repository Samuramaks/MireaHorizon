// import 'package:flutter/material.dart';

// import '../widgets/custom_widget.dart';

// class CalendarScreen extends StatelessWidget {
//   const CalendarScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const CustomWidget(
//         nameAppBar: 'Календарь',
//         body: Center(
//           child: Text('Календарь'),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Импортируем intl
import 'package:intl/date_symbol_data_local.dart'; // Для локализации

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

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru_RU', null); // Инициализация локализации
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Календарь',
      body: Center(
        child: Expanded(
          child: TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            locale: 'ru-RU',
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            firstDay: _firstDay,
            lastDay: _lastDay,
          ),
        ),
      ),
    );
  }
}
