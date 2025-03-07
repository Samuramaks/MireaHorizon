import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:mirea_horizon/presentation/bloc/base/navigation_bloc.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        nameAppBar: 'Настройки',
        body: Center(
          child: TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
                context.read<NavigationBloc>().add(ResetNavigationEvent());
              },
              child: const Text('Выйти из профиля')),
        ));
  }
}
