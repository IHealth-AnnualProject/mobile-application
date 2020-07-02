import 'package:betsbi/services/account/model/UserSkin.dart';
import 'package:betsbi/services/chat/state/ChatState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  final String userContactedId;
  final String userContactedName;
  final UserSkin userContactedSkin;

  ChatPage({@required this.userContactedId, @required this.userContactedName,@required this.userContactedSkin});

  @override
  ChatState createState() => ChatState();
}
