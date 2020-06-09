import 'package:async/async.dart';
import 'package:betsbi/controller/ChatController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/contact.dart';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ChatListContactView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/ContactChat.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatListContactPageState extends State<ChatListContactPage>
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
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    this._memorizer = AsyncMemoizer();
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
                child: ContactChat(
                  contact: contacts[index],
                ),
              ),
              itemCount: contacts.length,
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(2),
    );
  }
}
