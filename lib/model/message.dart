import 'package:flutter/cupertino.dart';

class Message {
  String userFromID;
  String content;

  Message({@required this.userFromID, @required this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userFromID: json['from'],
      content: json['content'],
    );
  }
}
