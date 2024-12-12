import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Календарь',
        body: Center(
          child: Text('Календарь'),
        ));
  }
}
