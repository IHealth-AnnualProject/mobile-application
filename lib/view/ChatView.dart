import 'dart:ui';
import 'package:betsbi/model/message.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget {
  final User userContacted;

  ChatPage({this.userContacted});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController mTextMessageController = new TextEditingController();
  List<Widget> list;
  Socket socket;

  @override
  void initState() {
    super.initState();
    list = new List<Widget>();
    _connectSocket();
    list.add(lineSendMessage());
  }

  _connectSocket() {
    socket = io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('connection', (data) => print(data));
    socket.on('newMessage', (data) => _onNewMessage(data));
    socket.on('join', (data) => print(data));
    socket.connect();
    socket.emit("sub", <String, dynamic>{
      'token': SettingsManager.currentToken,
    });
  }

  _onNewMessage(dynamic data) {
    Message receivedMessage = Message.fromJson(data);
    if (this.widget.userContacted.profileId == receivedMessage.userFromID) {
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
      body: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
      ),
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
                    'idReceiver': this.widget.userContacted.profileId
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
