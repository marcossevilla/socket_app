import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketBloc with ChangeNotifier {
  SocketBloc() {
    _initBloc();
  }

  ServerStatus _status = ServerStatus.connecting;

  void _initBloc() {
    var socket = io.io(
      'http://localhost:3001',
      {
        'transports': ['websocket'],
        'autoConnect': true,
      },
    )..on('connect', (_) => print('connected to server'));
  }
}
