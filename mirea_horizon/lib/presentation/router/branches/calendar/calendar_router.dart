import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/calendar/calendar.dart';
import 'calendar_routes_constants.dart';
import '../../../features/details/details_page.dart';

class CalendarRouter extends StatefulShellBranch {
  CalendarRouter()
      : super(
            initialLocation: CalendarRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                  path: CalendarRoutes.base(),
                  builder: (BuildContext context, GoRouterState state) =>
                      const CalendarScreen(),
                  routes: [
                    GoRoute(
                      path: CalendarRoutes.details(),
                      builder: (context, state) =>
                          const DetailsScreen(nameTitle: 'calendar'),
                    )
                  ])
            ]);
}
