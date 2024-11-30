import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'profile_routes_constants.dart';
import '../../../features/details/details_page.dart';
import '../../../features/profile/profile.dart';

class ProfileRouter extends StatefulShellBranch {
  ProfileRouter()
      : super(
            initialLocation: ProfileRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                  path: ProfileRoutes.base(),
                  builder: (BuildContext context, GoRouterState state) =>
                      const ProfileScreen(),
                  routes: [
                    GoRoute(
                      path: ProfileRoutes.details(),
                      builder: (context, state) =>
                          const DetailsScreen(nameTitle: 'profile'),
                    )
                  ])
            ]);
}
