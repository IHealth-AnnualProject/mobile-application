import 'package:betsbi/model/contact.dart';
import 'package:betsbi/state/ChatState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  final Contact userContacted;

  ChatPage({this.userContacted});

  @override
  ChatPageState createState() => ChatPageState();
}
