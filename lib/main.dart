import 'package:flutter/material.dart';
import 'package:socket_app/screens/home.dart';

void main() => runApp(SocketApp());

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
