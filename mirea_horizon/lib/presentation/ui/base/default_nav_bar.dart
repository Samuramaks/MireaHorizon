import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/base/bloc.dart';
import '../../router/routes/base/base.dart';

class DefaultNavBar extends StatelessWidget {
  final Widget child;

  const DefaultNavBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(BaseRoutes.main());
        break;
      case 1:
        context.go(BaseRoutes.tests());
        break;
      case 2:
        context.go(BaseRoutes.calendar());
        break;
      case 3:
        context.go(BaseRoutes.progress());
        break;
      case 4:
        context.go(BaseRoutes.profile());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc = GetIt.instance<NavigationBloc>();
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          navigationBloc.add(NavigationSelectTabEvent(index));
          _onItemTapped(context, index);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationBloc.state.currentIndex,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedItemColor: Theme.of(context).colorScheme.surface,
        showUnselectedLabels: true,
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
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Календарь',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Успеваемость',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
