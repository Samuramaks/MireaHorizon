import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/profile/profile_change_password.dart';
import 'package:mirea_horizon/presentation/features/profile/profile_settings.dart';
import 'profile_routes_constants.dart';
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
                        path: ProfileRoutes.settings(),
                        builder: (context, state) =>
                            const ProfileSettingsScreen(),
                        routes: [
                          GoRoute(
                            path: ProfileRoutes.change_passw(),
                            builder: (context, state) => ChangePasswordScreen(),
                          )
                        ])
                  ])
            ]);
}
