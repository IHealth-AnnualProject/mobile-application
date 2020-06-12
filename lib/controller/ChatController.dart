import 'dart:convert';

import 'package:betsbi/model/contact.dart';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:flutter/cupertino.dart';

class ChatController {
  static Future<List<Message>> getAllMessageIdFromContact(
      {String contactID, BuildContext context}) async {
    HttpManager httpManager =
        new HttpManager(path: 'conversation/$contactID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
      elementToReturn: getMessageFromJson(jsonToDecode: httpManager.response.body),
    );
    return responseManager.checkResponseAndRetrieveInformation();
  }

  static List<Message> getMessageFromJson({@required String jsonToDecode}){
    var messages = new List<Message>();
    Iterable list = json.decode(jsonToDecode);
    messages.addAll(
        list.map((model) => Message.fromJsonOnListMessage(model)).toList());
    return messages;
  }
  static List<Contact> getContactFromJson({@required String jsonToDecode}){
    var contacts = new List<Contact>();
    Iterable list = json.decode(jsonToDecode);
    contacts.addAll(list.map((model) => Contact.fromJson(model)).toList());
    return contacts;
  }

  static Future<List<Contact>> getAllContact({BuildContext context}) async {
    HttpManager httpManager = new HttpManager(path: 'conversation/', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        elementToReturn: getContactFromJson(jsonToDecode: httpManager.response.body)
    );
    return responseManager.checkResponseAndRetrieveInformation();
  }

  static void setAllNewMessageFromContact({@required List<Contact> contacts}){
    SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
    contacts.forEach((element) async {
      element.setNewMessage(
        await newMessage.countByIdFromAndTo(
            userIdTo: SettingsManager.applicationProperties.getCurrentId(),
            userIdFrom: element.userId),
      );
    });
  }


}
