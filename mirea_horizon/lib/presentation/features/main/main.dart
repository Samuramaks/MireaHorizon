import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Main',
        body: Center(
          child: Text('Main'),
        ));
  }
}
