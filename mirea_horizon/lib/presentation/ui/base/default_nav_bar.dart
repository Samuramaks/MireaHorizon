import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/services/avatar/user_avatar_service.dart';
import '../../bloc/base/bloc.dart';

class DefaultNavBar extends StatelessWidget {
  const DefaultNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc = GetIt.instance<NavigationBloc>();
    final UserAvatarService _avatarService =
        GetIt.instance<UserAvatarService>();
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: ListenableBuilder(
          listenable: _avatarService,
          builder: (BuildContext context, Widget? child) {
            return BottomNavigationBar(
                onTap: (int index) {
                  navigationBloc.add(NavigationSelectTabEvent(index));
                  _onItemTapped(context, index);
                },
                type: BottomNavigationBarType.fixed,
                currentIndex: navigationBloc.state.currentIndex,
                backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                unselectedItemColor: Theme.of(context).colorScheme.primary,
                selectedItemColor: Theme.of(context).colorScheme.onSurface,
                showUnselectedLabels: true,
                selectedFontSize: 12,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Главная',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.folder_open_outlined),
                    label: 'Тестирование',
                  ),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.work_outline_outlined),
                      label: 'Центр карьеры'),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_rounded),
                    label: 'Календарь',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_sharp),
                    label: 'Прогресс',
                  ),
                  BottomNavigationBarItem(
                      icon: _avatarService.avatarUrl != null &&
                              _avatarService.avatarUrl!.isNotEmpty
                          ? CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  NetworkImage(_avatarService.avatarUrl!),
                              backgroundColor: Colors.transparent)
                          : const Icon(Icons.person_outline_rounded),
                      label: "Профиль"),
                ]);
          },
        ));
  }
}
