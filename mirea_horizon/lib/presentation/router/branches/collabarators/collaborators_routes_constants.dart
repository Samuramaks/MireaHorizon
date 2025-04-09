import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class CollaboratorRoutes {
  static const base = RouterConst("/app/collaborator");
  static const details = RouterConst("details", base: CollaboratorRoutes.base);
}
