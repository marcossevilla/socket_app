import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketBloc with ChangeNotifier {
  SocketBloc() {
    _initBloc();
  }

  ServerStatus _status = ServerStatus.connecting;
  ServerStatus get status => _status;

  io.Socket _socket;
  io.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void _initBloc() {
    _socket = io.io('http://localhost:3001', {
      'transports': ['websocket'],
      'autoConnect': true,
    })
      ..on('connect', (_) {
        _status = ServerStatus.online;
        notifyListeners();
      })
      ..on('disconnect', (_) {
        _status = ServerStatus.offline;
        notifyListeners();
      });
  }
}
