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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server status: ${bloc.status}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          bloc.emit(
            'emit_message',
            {'name': 'Flutter', 'message': 'Hello'},
          );
        },
      ),
    );
  }
}
