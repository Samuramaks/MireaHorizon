import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/data/models/tests/test_models.dart';
import 'package:mirea_horizon/presentation/features/tests/test_detail_screen.dart';
import 'package:mirea_horizon/presentation/features/tests/test_info_screen.dart';
import 'package:mirea_horizon/presentation/features/tests/test_result_screen.dart';
import 'package:mirea_horizon/presentation/features/tests/tests_screen.dart';

import 'tests_routes_constants.dart';

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
                      builder: (context, state) {
                        final test = state.extra as Test;
                        return TestDetailScreen(
                          test: test,
                        );
                      },
                    ),
                    GoRoute(
                      path: TestsRoutes.result(),
                      builder: (context, state) {
                        final testResultArguments =
                            state.extra as TestResultArguments;
                        return TestResultScreen(
                          testResultArguments: testResultArguments,
                        );
                      },
                    ),
                    GoRoute(
                      path: TestsRoutes.info(),
                      builder: (context, state) => TestInfoScreen(),
                    )
                  ])
            ]);
}
