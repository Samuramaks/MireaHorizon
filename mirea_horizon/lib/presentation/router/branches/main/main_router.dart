import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'main_routes_constants.dart';
import '../../../features/details/details_page.dart';
import '../../../features/main/main.dart';

class MainRouter extends StatefulShellBranch {
  MainRouter()
      : super(
            initialLocation: MainRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                  path: MainRoutes.base(),
                  builder: (BuildContext context, GoRouterState state) =>
                      const MainScreen(),
                  routes: [
                    GoRoute(
                      path: MainRoutes.details(),
                      builder: (context, state) =>
                          DetailsScreen(nameTitle: 'main'),
                    )
                  ])
            ]);
}
