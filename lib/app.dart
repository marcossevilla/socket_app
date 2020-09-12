import 'package:flutter/material.dart';

import 'views/screens/home.dart';

class SocketApp extends StatelessWidget {
  static const String name = 'Socket App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: name,
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
      },
    );
  }
}
