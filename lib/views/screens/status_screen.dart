import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../blocs/socket_bloc.dart';

class StatusScreen extends StatelessWidget {
  static const String route = 'status';

  static Route go() => MaterialPageRoute<void>(builder: (_) => StatusScreen());

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SocketBloc>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: const Text(
          'Socket Status',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server status: ${bloc.status}'),
          ],
        ),
      ),
    );
  }
}
