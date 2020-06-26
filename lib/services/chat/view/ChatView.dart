import 'package:betsbi/services/chat/state/ChatState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  final String userContactedId;
  final String userContactedName;

  ChatPage({@required this.userContactedId, @required this.userContactedName});

  @override
  ChatState createState() => ChatState();
}
