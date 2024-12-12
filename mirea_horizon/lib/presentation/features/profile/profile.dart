import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Профиль',
        body: Center(
          child: Text('Профиль'),
        ));
  }
}
