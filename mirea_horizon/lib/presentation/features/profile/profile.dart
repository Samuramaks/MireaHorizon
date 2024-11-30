import 'package:flutter/material.dart';

import '../widgets/custom_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        nameAppBar: 'Profile',
        body: Center(
          child: Text('Profile'),
        ));
  }
}
