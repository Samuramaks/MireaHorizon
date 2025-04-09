import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/features/collaborators/collaborators.dart';
import 'package:mirea_horizon/presentation/router/branches/collabarators/collaborators_routes_constants.dart';

class CollaboratorRouter extends StatefulShellBranch {
  CollaboratorRouter()
      : super(
            initialLocation: CollaboratorRoutes.base(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: <RouteBase>[
              GoRoute(
                path: CollaboratorRoutes.base(),
                builder: (BuildContext context, GoRouterState state) =>
                    Collaborators(),
              )
            ]);
}
