import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mirea_horizon/data/repositories/local_data/local_data.dart';

import '../widgets/custom_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _getNameAndEmailBySP();
  }

  void _getNameAndEmailBySP() async {
    setState(() {
      name = FirebaseAuth.instance.currentUser!.displayName ??
          'Имя не указано'; // Устанавливаем значение по умолчанию
      email = FirebaseAuth.instance.currentUser!.email ??
          'Электронная почта не указана'; // Устанавливаем значение по умолчанию
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        nameAppBar: 'Профиль',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              const SizedBox(
                height: 10.0,
              ),
              Text(email)
            ],
          ),
        ));
  }
}
