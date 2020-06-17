import 'package:badges/badges.dart';
import 'package:betsbi/model/contact.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:betsbi/view/ChatView.dart';
import 'package:betsbi/view/ReportView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactChat extends StatefulWidget {
  final Contact contact;

  ContactChat({this.contact});

  @override
  _ContactChatState createState() => _ContactChatState();
}

class _ContactChatState extends State<ContactChat> {
  SQLLiteNewMessage newMessage;

  @override
  void initState() {
    super.initState();
    newMessage = SQLLiteNewMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading:
              widget.contact.isPsy ? Icon(Icons.spa) : Icon(Icons.account_box),
          title: Text(widget.contact.username),
          trailing: Badge(
            badgeContent: Text(
              this.widget.contact.newMessage.toString(),
              style: TextStyle(color: Colors.white),
            ),
            position: BadgePosition.topRight(top: 0, right: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        userContactedId: widget.contact.userId,
                      )),
            );
          },
          subtitle: Text(widget.contact.isPsy
              ? SettingsManager.mapLanguage["PsyChoice"]
              : SettingsManager.mapLanguage["UserChoice"]),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: SettingsManager.mapLanguage["Delete"],
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print("delete")
        ),
        IconSlideAction(
          caption: SettingsManager.mapLanguage["Report"],
          color: Colors.black87,
          icon: Icons.report,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportView(
                  userId: this.widget.contact.userId,
                  userName: this.widget.contact.username,
                )),
          ).whenComplete(() => this.setState(() { })),
        ),
      ],
    );
  }
}
