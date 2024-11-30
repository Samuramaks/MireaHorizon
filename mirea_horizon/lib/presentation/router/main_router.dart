import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/router/export_main_widgets.dart';

import '../ui/base/default_nav_bar.dart';
import 'routes/base/base.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRoute() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: BaseRoutes.base(),
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return DefaultNavBar(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            MainRouter(),
            TestsRouter(),
            CalendarRouter(),
            ProgressRouter(),
            ProfileRouter(),
          ])
    ],
  );
}
