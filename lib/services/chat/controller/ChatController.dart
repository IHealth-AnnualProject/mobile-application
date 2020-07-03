import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/chat/model/contact.dart';
import 'package:betsbi/services/chat/model/message.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/chat/SQLLiteNewMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatController {
  static Future<List<Message>> getAllMessageIdFromContact(
      {@required String contactID, @required BuildContext context}) async {
    HttpManager httpManager =
        new HttpManager(path: 'conversation/$contactID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    print(httpManager.response.statusCode);
    return responseManager.checkResponseAndReturnTheDesiredElement(
        elementToReturn:
            getMessageFromJson(jsonToDecode: httpManager.response.body));
  }

  static List<Message> getMessageFromJson({@required String jsonToDecode}) {
    var messages = new List<Message>();
    Iterable list = json.decode(jsonToDecode);
    messages.addAll(list.map((model) => Message.fromJsonOnListMessage(model)).toList());
    return messages;
  }

  static List<Contact> getContactFromJson({@required String jsonToDecode}) {
    var contacts = new List<Contact>();
    Iterable list = json.decode(jsonToDecode);
    contacts.addAll(list.map((model) => Contact.fromJson(model)).toList());
    return contacts;
  }

  static Future<List<Contact>> getAllContact(
      {@required BuildContext context}) async {
    HttpManager httpManager =
        new HttpManager(path: 'conversation', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseAndReturnTheDesiredElement(
        elementToReturn:
            getContactFromJson(jsonToDecode: httpManager.response.body));
  }

  static void setAllNewMessageFromContact({@required List<Contact> contacts}) {
    SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
    contacts.forEach((element) async {
      element.setNewMessage(
        await newMessage.countByIdFromAndTo(
            userIdTo: SettingsManager.applicationProperties.getCurrentId(),
            userIdFrom: element.userId),
      );
    });
  }

  static Future<List<Contact>> getAllContactAsInterface({@required BuildContext context,@required Function onNewMessage}) async{
    List<Contact> contacts = List<Contact>();
    Socket socket =
        io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });
    socket.on('newMessage', (data) => onNewMessage(data, contacts));
    contacts = await ChatController.getAllContact(context: context);
    SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
    contacts.removeWhere((contact) =>
    contact.userId == SettingsManager.cfg.getString("ChatBotId"));
    contacts.forEach((contact) async {
      contact.setNewMessage(await newMessage.countByIdFromAndTo(
          userIdFrom: contact.userId,
          userIdTo: SettingsManager.applicationProperties.getCurrentId()));
    });
    return contacts;
  }
}
