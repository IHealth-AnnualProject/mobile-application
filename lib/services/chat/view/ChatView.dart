import 'package:betsbi/services/chat/ChatState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  final String userContactedId;

  ChatPage({@required this.userContactedId});

  @override
  ChatPageState createState() => ChatPageState();
}
