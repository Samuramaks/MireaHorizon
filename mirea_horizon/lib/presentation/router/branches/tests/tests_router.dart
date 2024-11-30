import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/tests/tests.dart';
import 'tests_routes_constants.dart';
import '../../../features/details/details_page.dart';

class TestsRouter extends StatefulShellBranch {
  TestsRouter()
      : super(
            initialLocation: TestsRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                  path: TestsRoutes.base(),
                  builder: (BuildContext context, GoRouterState state) =>
                      const TestsScreen(),
                  routes: [
                    GoRoute(
                      path: TestsRoutes.details(),
                      builder: (context, state) =>
                          const DetailsScreen(nameTitle: 'tests'),
                    )
                  ])
            ]);
}
