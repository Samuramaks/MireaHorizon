import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key, required this.nameAppBar, required this.body});
  final String nameAppBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(nameAppBar),
        backgroundColor: colorScheme.primary,
        centerTitle: true,
      ),
      body: body,
    );
  }
}
