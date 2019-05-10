import 'package:flutter/material.dart';

import 'dashboard_bloc.dart';
export 'dashboard_bloc.dart';

class DashboardProvider extends InheritedWidget {
  final DashboardBloc bloc;

  DashboardProvider({Key key, Widget child})
      : bloc = DashboardBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static DashboardBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DashboardProvider)
            as DashboardProvider)
        .bloc;
  }
}
