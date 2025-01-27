import 'package:flutter/material.dart';
import 'package:graphaello/graphaello.dart';

import '../widgets/custom_widget.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Успеваемость',
        body: Center(
          child: PieChartWithLegend(data: [
            PieData(name: 'Лягушки', value: 40, color: Colors.green),
            PieData(name: 'Пчелы', value: 30, color: Colors.yellow),
            PieData(name: 'Драконы', value: 30, color: Colors.red),
          ]),
        ));
  }
}
