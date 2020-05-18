import 'dart:ui';
import 'package:async/async.dart';
import 'package:betsbi/controller/ChatController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/contact.dart';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/sqlite/SQLLiteNewMessage.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget {
  final Contact userContacted;

  ChatPage({this.userContacted});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  TextEditingController mTextMessageController = new TextEditingController();
  List<Widget> list;
  Socket socket;
  AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    this._memoizer = AsyncMemoizer();
    super.dispose();
  }

  _instanciateChatWithAllMessageAndInput() {
    return this._memoizer.runOnce(() async {
      list = new List<Widget>();
      socket =
          io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.on('newMessage', (data) => _onNewMessage(data));
      await ChatController.getAllMessageIdFromContact(
              contactID: this.widget.userContacted.userId)
          .then((listMessage) {
        listMessage.forEach((message) {
          list.add(SettingsManager.currentId == message.userFromID
              ? myMessage(content: message.content)
              : hisMessage(content: message.content));
        });
      });
      list.add(lineSendMessage());
      list = list.reversed.toList();
      SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
      SettingsManager.newMessage -= await newMessage
          .countByIdFromAndTo(
              userIdFrom: this.widget.userContacted.userId,
              userIdTo: SettingsManager.currentId)
          .then((value) async =>
              await newMessage.deleteById(this.widget.userContacted.userId));
    });
  }

  _onNewMessage(dynamic data) {
    Message receivedMessage = Message.fromJson(data);
    if (this.widget.userContacted.userId == receivedMessage.userFromID) {
      list.insert(1, hisMessage(content: receivedMessage.content));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppSearchBar.appSearchBarNormal(
        title: this.widget.userContacted.username,
      ),
      body: FutureBuilder(
          future: _instanciateChatWithAllMessageAndInput(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
              );
            }
          }),
      bottomNavigationBar: BottomNavigationBarFooter(2),
    );
  }

  Container lineSendMessage() {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: mTextMessageController,
              decoration: InputDecoration(
                  labelText: SettingsManager.mapLanguage["SendMessage"] != null
                      ? SettingsManager.mapLanguage["SendMessage"]
                      : "",
                  filled: true,
                  fillColor: Colors.white,
                  hintText: SettingsManager.mapLanguage["SendMessage"] != null
                      ? SettingsManager.mapLanguage["SendMessage"]
                      : "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          ),
          RaisedButton(
            color: Color.fromRGBO(255, 195, 0, 1),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              if (mTextMessageController.text.isNotEmpty) {
                socket.emit("sendMessage", <String, dynamic>{
                  'token': SettingsManager.currentToken,
                  'data': {
                    'content': mTextMessageController.text,
                    'idReceiver': this.widget.userContacted.userId
                  }
                });
                list.insert(
                  1,
                  myMessage(content: mTextMessageController.text),
                );
                setState(() {});
              }
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Bubble myMessage({@required content}) {
    return Bubble(
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      child: Text(
        content,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Bubble hisMessage({@required content}) {
    return Bubble(
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      color: Color.fromRGBO(225, 255, 199, 1.0),
      child: Text(
        content,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
