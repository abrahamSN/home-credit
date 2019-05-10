import 'package:flutter/material.dart';

import 'blocs/dashboard_provider.dart';
import 'screens/dashboard.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardProvider(
      child: MaterialApp(
        title: 'Home Credit',
        initialRoute: '/',
        routes: {
          '/': (context) {
            final bloc = DashboardProvider.of(context);
            bloc.fetchApi();
            return Dashboard();
          },
        },
      ),
    );
  }
}
