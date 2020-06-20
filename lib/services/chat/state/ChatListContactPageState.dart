import 'package:async/async.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/chat/SQLLiteNewMessage.dart';
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
import 'package:betsbi/tools/ContactChat.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatListContactState extends State<ChatListContactPage>
    with WidgetsBindingObserver {
  List<Contact> contacts;
  Socket socket;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  _onNewMessage(dynamic data) async {
    Message receivedMessage = Message.fromJson(data);
    int index = 0;
    contacts.forEach((element) {
      if (element.userId == receivedMessage.userFromID) {
        contacts[index].newMessage++;
      }
      index++;
    });
    if(mounted)
    setState(() {});
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

  findContacts() {
    return this._memorizer.runOnce(() async {
      contacts = new List<Contact>();
      socket =
          io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.on('newMessage', (data) => _onNewMessage(data));
      contacts = await ChatController.getAllContact(context: context);
      SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
      contacts.forEach((contact) async {
        contact.setNewMessage(await newMessage.countByIdFromAndTo(userIdFrom: contact.userId, userIdTo: SettingsManager.applicationProperties.getCurrentId()));
      });
      return context;
    });
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
        future: findContacts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return WaitingWidget();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                            userContactedId: contacts[index].userId,
                          ),),
                    ).whenComplete(() => this.setState(() {_memorizer = AsyncMemoizer(); }));
                  },
                  child: ContactChat(
                    contact: contacts[index],
                  ),
                ),
              ),
              itemCount: contacts.length,
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: 2,
      ),
    );
  }
}
