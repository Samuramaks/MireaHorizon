import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {super.key,
      required this.nameAppBar,
      required this.body,
      this.bottom,
      this.actions});
  final String nameAppBar;
  final Widget body;
  final PreferredSize? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameAppBar,
          style: TextStyle(color: colorScheme.onSurface),
        ),
        // backgroundColor: colorScheme.secondary,
        centerTitle: true,
        bottom: bottom,
        actions: actions,
      ),
      body: body,
    );
  }
}
