import 'dart:io';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/model/newMessage.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'SettingsManager.dart';

class SocketManager {
  static Socket socket;

  static connectSocket() async {
    socket =
        io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('connection', (data) => _onConnection(data));
    socket.on('newMessage', (data) => _onNewMessage(data));
    socket.on('join', (data) => _onJoin(data));
    socket.connect();
    socket.emit("sub", <String, dynamic>{
      'token': SettingsManager.currentToken,
    });
    SQLLiteNewMessage sqlLiteNewMessage = new SQLLiteNewMessage();
    sqlLiteNewMessage.openDatabaseandCreateTable().then((value) async =>
        SettingsManager.newMessage +=
            await sqlLiteNewMessage.countByIdTo(SettingsManager.currentId));
  }

  static _onConnection(dynamic data) {
    print(data);
  }

  static connectAndChangeNewMessage(Function onNewMessage) {
    socket =
        io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('newMessage', (data) => onNewMessage(data));
  }

  static _onJoin(dynamic data) {
    print(data);
  }

  static _onNewMessage(dynamic data) {
    SettingsManager.newMessage++;
    SQLLiteNewMessage sqlLiteNewMessage = new SQLLiteNewMessage();
    Message receivedMessage = Message.fromJson(data);
    sqlLiteNewMessage.insert(
      new NewMessage(
        userIdTo: SettingsManager.currentId,
        userIdFrom: receivedMessage.userFromID,
      ),
    );
  }

  static _disconnect() {
    socket.disconnect();
  }
}
