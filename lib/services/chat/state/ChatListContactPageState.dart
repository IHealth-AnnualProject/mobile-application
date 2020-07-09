import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/chat/controller/ChatController.dart';
import 'package:betsbi/services/chat/model/contact.dart';
import 'package:betsbi/services/chat/view/ChatView.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/chat/model/message.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/chat/view/ChatListContactView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/services/chat/widget/ContactChat.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListContactState extends State<ChatListContactPage>
    with WidgetsBindingObserver {

  _onNewMessage(dynamic data, List<Contact> contacts) async {
    Message receivedMessage = Message.fromJson(data);
    int index = 0;
    contacts.forEach((element) {
      if (element.userId == receivedMessage.userFromID) {
        contacts[index].newMessage++;
      }
      index++;
    });
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      body: FutureBuilder(
        future: ChatController.getAllContactAsInterface(
            context: context, onNewMessage: _onNewMessage),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return WaitingWidget();
          } else {
            return Column(
              children: <Widget>[
                Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            userContactedId:
                                SettingsManager.cfg.getString("ChatBotId"),
                            userContactedName:
                                SettingsManager.cfg.getString("ChatBotId"),
                            userContactedSkin: AccountController
                                .getUserAvatarAccordingToHisIdForAccountAsObject(
                                    userSkin: "1AAAA_1AAAA_1AAAA"),
                          ),
                        ),
                      ).whenComplete(
                        () => setState(
                          () {},
                        ),
                      );
                    },
                    child: ContactChat(
                      contact: Contact(
                          isPsy: false,
                          newMessage: 0,
                          userId: SettingsManager.cfg.getString("ChatBotId"),
                          username: SettingsManager.cfg.getString("ChatBotId"),
                          skin: "1AAAA_1AAAA_1AAAA"),
                    ),
                  ),
                ),
                snapshot.data.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) => Card(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    userContactedId:
                                        snapshot.data[index].userId,
                                    userContactedName:
                                        snapshot.data[index].username,
                                    userContactedSkin: AccountController
                                        .getUserAvatarAccordingToHisIdForAccountAsObject(
                                            userSkin:
                                                snapshot.data[index].skin),
                                  ),
                                ),
                              ).whenComplete(
                                () => this.setState(
                                  () {},
                                ),
                              );
                            },
                            child: ContactChat(
                              contact: snapshot.data[index],
                            ),
                          ),
                        ),
                        itemCount: snapshot.data.length,
                      )
                    : Center(
                        child: DefaultTextTitle(
                          title: SettingsManager.mapLanguage["FindFriends"],
                        ),
                      ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: 2,
      ),);
  }
}
