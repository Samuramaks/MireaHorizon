import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    // navigationBloc.add(NavigationLoadEvent());

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            navigationBloc.add(NavigationSelectTabEvent(index));
            _onItemTapped(context, index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationBloc.state.currentIndex,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          selectedItemColor: Theme.of(context).primaryColor,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Тестирование',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded), label: 'Календарь'),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'Прогресс',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ]
          // items: navigationBloc.state.isOpen
          //     ? const [
          //         BottomNavigationBarItem(
          //           icon: Icon(Icons.map),
          //           label: 'Карты',
          //         ),
          //         BottomNavigationBarItem(
          //             icon: Icon(Icons.videocam_sharp), label: 'Видео'),
          //         BottomNavigationBarItem(
          //           icon: Icon(Icons.note),
          //           label: 'Методики',
          //         ),
          //         BottomNavigationBarItem(
          //           icon: Icon(Icons.start),
          //           label: 'Приветствие',
          //         ),
          //       ]
          // : const [
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.newspaper), label: "n"),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.map),
          //       label: 'k',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.messenger),
          //       label: "d",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.schedule),
          //       label: 'i',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person),
          //       label: "m",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.start),
          //       label: 'b',
          //     ),
          //   ],
          ),
    );
  }
}
