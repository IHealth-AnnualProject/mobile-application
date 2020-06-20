import 'dart:ui';
import 'package:async/async.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/chat/controller/ChatController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/chat/model/message.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/chat/SQLLiteNewMessage.dart';
import 'package:betsbi/services/chat/view/ChatView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatState extends State<ChatPage> with WidgetsBindingObserver {
  TextEditingController mTextMessageController = new TextEditingController();
  List<Widget> messages = new List<Widget>();
  Socket socket;
  AsyncMemoizer _memorizer = AsyncMemoizer();

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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    this._memorizer = AsyncMemoizer();
    super.dispose();
  }

  _instanciateChatWithAllMessageAndInput() {
    return this._memorizer.runOnce(() async {
      instantiateSocketForChat(onNewMessage: _onNewMessage);
      await ChatController.getAllMessageIdFromContact(
              contactID: this.widget.userContactedId)
          .then((listMessage) {
        listMessage.forEach((message) {
          messages.add(SettingsManager.applicationProperties.getCurrentId() ==
                  message.userFromID
              ? myMessage(content: message.content)
              : hisMessage(content: message.content));
        });
      });
      messages.add(lineSendMessage());
      messages = messages.reversed.toList();
      await updateSettingsPropertyNewMessageLessWithCurrentNewMessageFromThisUserAndRemoveITFromBDD();
    });
  }

  Future updateSettingsPropertyNewMessageLessWithCurrentNewMessageFromThisUserAndRemoveITFromBDD() async {
    SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
    SettingsManager.applicationProperties.setNewMessage(SettingsManager
            .applicationProperties
            .getNewMessage() -
        await newMessage
            .countByIdFromAndTo(
                userIdFrom: this.widget.userContactedId,
                userIdTo:
                    SettingsManager.applicationProperties.getCurrentId())
            .then((value) async =>
                await newMessage.deleteById(this.widget.userContactedId)));
  }

  _onNewMessage(dynamic data) {
    Message receivedMessage = Message.fromJson(data);
    if (this.widget.userContactedId == receivedMessage.userFromID) {
      messages.insert(1, hisMessage(content: receivedMessage.content));
      if(mounted)
        setState(() {});
    }
  }

    void instantiateSocketForChat({@required Function onNewMessage}) {
    socket =
        io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });
    socket.on('newMessage', (data) => onNewMessage(data));
  }

   void emitNewMessage({@required String idReceiver,@required String content})
  {
    socket.emit("sendMessage", <String, dynamic>{
      'token':
      SettingsManager.applicationProperties.getCurrentToken(),
      'data': {
        'content': content,
        'idReceiver': idReceiver,
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppSearchBar(),
      body: FutureBuilder(
          future: _instanciateChatWithAllMessageAndInput(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: WaitingWidget(),
              );
            } else {
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return messages[index];
                },
              );
            }
          }),
      bottomNavigationBar: BottomNavigationBarFooter(selectedBottomIndexOffLine: null, selectedBottomIndexOnline: 2,),
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
                emitNewMessage(idReceiver: this.widget.userContactedId, content: mTextMessageController.text);
                messages.insert(
                  1,
                  myMessage(content: mTextMessageController.text),
                );
                setState(() {mTextMessageController = new TextEditingController(); });
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
