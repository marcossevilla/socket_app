import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../blocs/socket_bloc.dart';

class StatusScreen extends StatelessWidget {
  static const String route = 'status';

  static Route go() => MaterialPageRoute<void>(builder: (_) => StatusScreen());

  @override
  Widget build(BuildContext context) {
    final socket = context.watch<SocketBloc>();

    return const Scaffold(
      body: Center(
        child: Text('Hello world!'),
      ),
    );
  }
}
