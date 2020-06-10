import 'dart:convert';

import 'package:betsbi/model/contact.dart';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/model/response.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ChatController {
  static Future<List<Message>> getAllMessageIdFromContact(
      {String contactID, BuildContext context}) async {
    HttpManager httpManager =
    new HttpManager(path: 'conversation/$contactID/user');
    await httpManager.get();
    return _checkResponseAndGetAllMessageIfOk(httpManager.response, context);
  }

  static List<Message> _checkResponseAndGetAllMessageIfOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      var messages = new List<Message>();
      Iterable list = json.decode(response.body);
      messages.addAll(
          list.map((model) => Message.fromJsonOnListMessage(model)).toList());
      return messages;
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return new List<Message>();
    }
  }

  static Future<List<Contact>> getAllContact({BuildContext context}) async {
    HttpManager httpManager =
    new HttpManager(path: 'conversation/');
    await httpManager.get();
    return _checkResponseAndGetAllContactIfOk(httpManager.response, context);
  }

  static List<Contact> _checkResponseAndGetAllContactIfOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      var contacts = new List<Contact>();
      Iterable list = json.decode(response.body);
      contacts.addAll(list.map((model) => Contact.fromJson(model)).toList());
      SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
      contacts.forEach((element) async {
        element.setNewMessage(
          await newMessage.countByIdFromAndTo(
              userIdTo: SettingsManager.applicationProperties.getCurrentId(), userIdFrom: element.userId),
        );
      });
      return contacts;
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return new List<Contact>();
    }
  }

}
