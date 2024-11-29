import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_horizon/presentation/bloc/base/bloc.dart';

class RouterConst {
  static GoRouter? router;
  final String path;
  final RouterConst? base;

  const RouterConst(this.path, {this.base});

  String call() {
    return path;
  }

  String getPath() {
    var rpath = path;

    return rpath;
  }

  String getFullPath() {
    return '${base?.getFullPath()}/$path'
        .replaceAll(RegExp(r"[/]{2,}"), "/")
        .replaceAll("null", "");
  }

  void push({dynamic data}) {
    router?.push(getFullPath(), extra: data);
  }

  void navigate(BuildContext? context, {dynamic data}) {
    String rpath = getFullPath();
    if (context != null) {
      final navigationBloc = GetIt.instance<NavigationBloc>();
      int index = 0;

      switch (rpath) {
        case String path when path.contains('main'):
          index = 0;
          break;
        case String path when path.contains('tests'):
          index = 1;
          break;
        case String path when path.contains('calendar'):
          index = 2;
          break;
        case String path when path.contains('progress'):
          index = 3;
          break;
        case String path when path.contains('profile'):
          index = 4;
          break;
      }
      navigationBloc.add(NavigationSelectTabEvent(index));
    }
    router?.replace(rpath, extra: data);
  }

  void pop() {
    router?.pop();
  }
}
