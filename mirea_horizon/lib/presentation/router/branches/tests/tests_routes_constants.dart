import 'package:mirea_horizon/presentation/router/routes/data_source/route_const.dart';

class TestsRoutes {
  static const base = RouterConst("/tests");
  static const details = RouterConst("details", base: TestsRoutes.base);
}
