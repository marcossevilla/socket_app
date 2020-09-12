import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String route = 'home';

  static Route go() => MaterialPageRoute<void>(builder: (_) => HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
