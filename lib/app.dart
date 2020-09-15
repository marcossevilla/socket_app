import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'blocs/socket_bloc.dart';
import 'views/screens/home.dart';
import 'views/screens/status.dart';

class SocketApp extends StatelessWidget {
  static const String name = 'Socket App';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketBloc()),
      ],
      child: MaterialApp(
        title: name,
        initialRoute: StatusScreen.route,
        routes: {
          HomeScreen.route: (_) => HomeScreen(),
          StatusScreen.route: (_) => StatusScreen(),
        },
      ),
    );
  }
}
