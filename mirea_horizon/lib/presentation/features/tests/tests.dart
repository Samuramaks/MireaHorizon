import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Tests',
        body: Center(
          child: Text('Tests'),
        ));
  }
}
