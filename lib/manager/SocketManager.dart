import 'dart:io';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/model/newMessage.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'SQLLiteManager.dart';
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
      'token': SettingsManager.applicationProperties.getCurrentToken(),
    });
    SQLLiteNewMessage sqlLiteNewMessage = new SQLLiteNewMessage();
    SQLLiteManager.openDatabaseAndCreateTable().then((value) async =>
        SettingsManager.applicationProperties.setNewMessage(
            SettingsManager.applicationProperties.getNewMessage() +
                await sqlLiteNewMessage.countByIdTo(
                    SettingsManager.applicationProperties.getCurrentId())));
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
    SettingsManager.applicationProperties.setNewMessage(
        SettingsManager.applicationProperties.getNewMessage() + 1);
    SQLLiteNewMessage sqlLiteNewMessage = new SQLLiteNewMessage();
    Message receivedMessage = Message.fromJson(data);
    sqlLiteNewMessage.insert(
      new NewMessage(
        userIdTo: SettingsManager.applicationProperties.getCurrentId(),
        userIdFrom: receivedMessage.userFromID,
      ),
    );
  }

  static _disconnect() {
    socket.disconnect();
  }
}
