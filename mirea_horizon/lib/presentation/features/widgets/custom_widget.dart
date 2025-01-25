import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {super.key, required this.nameAppBar, required this.body, this.bottom});
  final String nameAppBar;
  final Widget body;
  final PreferredSize? bottom;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameAppBar,
          style: TextStyle(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.secondary,
        centerTitle: true,
        bottom: bottom,
      ),
      body: body,
    );
  }
}
