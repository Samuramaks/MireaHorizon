import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Успеваемость',
        body: Center(
          child: Text('Успеваемость'),
        ));
  }
}
