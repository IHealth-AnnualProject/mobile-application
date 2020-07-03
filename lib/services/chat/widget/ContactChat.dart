import 'package:badges/badges.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/chat/model/contact.dart';
import 'package:betsbi/services/report/view/ReportView.dart';
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

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: AccountController.getUserAvatarAccordingToHisIdForAccountAsSearchWidget(userSkin: this.widget.contact.skin),
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
                builder: (context) => ReportPage(
                  userId: this.widget.contact.userId,
                  userName: this.widget.contact.username,
                )),
          ).whenComplete(() => this.setState(() { })),
        ),
      ],
    );
  }
}
