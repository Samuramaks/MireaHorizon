import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/progress/progress.dart';
import 'progress_routes_constants.dart';
import '../../../features/details/details_page.dart';

class ProgressRouter extends StatefulShellBranch {
  ProgressRouter()
      : super(
            initialLocation: ProgressRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                  path: ProgressRoutes.base(),
                  builder: (BuildContext context, GoRouterState state) =>
                      const ProgressScreen(),
                  routes: [
                    GoRoute(
                      path: ProgressRoutes.details(),
                      builder: (context, state) =>
                          const DetailsScreen(nameTitle: 'progress'),
                    )
                  ])
            ]);
}
