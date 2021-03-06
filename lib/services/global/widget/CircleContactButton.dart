import 'package:betsbi/services/account/model/UserSkin.dart';
import 'package:betsbi/services/chat/view/ChatView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleContactButton extends StatelessWidget {
  final String userContactedId;
  final String userContactedName;
  final UserSkin userContactedSkin;

  CircleContactButton(
      {@required this.userContactedId, @required this.userContactedName, @required this.userContactedSkin});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: StadiumBorder(),
      color: Color.fromRGBO(255, 195, 0, 1),
      child: Text(
        "Contact",
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 100),
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userContactedName: userContactedName,
            userContactedId: userContactedId, userContactedSkin: userContactedSkin,

          ),
        ),
      ),
    );
  }
}
