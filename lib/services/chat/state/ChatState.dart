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
import 'package:betsbi/tools/AvatarSkinWidget.dart';
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
    socket.disconnect();
    super.dispose();
  }

  _instantiateChatWithAllMessageAndInput() {
    return this._memorizer.runOnce(() async {
      instantiateSocketForChat(onNewMessage: _onNewMessage);
      await ChatController.getAllMessageIdFromContact(
              contactID: this.widget.userContactedId, context: context)
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
      return messages;
    });
  }

  Future
      updateSettingsPropertyNewMessageLessWithCurrentNewMessageFromThisUserAndRemoveITFromBDD() async {
    SQLLiteNewMessage newMessage = new SQLLiteNewMessage();
    SettingsManager.applicationProperties.setNewMessage(SettingsManager
            .applicationProperties
            .getNewMessage() -
        await newMessage
            .countByIdFromAndTo(
                userIdFrom: this.widget.userContactedId,
                userIdTo: SettingsManager.applicationProperties.getCurrentId())
            .then((value) async =>
                await newMessage.deleteById(this.widget.userContactedId)));
  }

  _onNewMessage(dynamic data) {
    Message receivedMessage = Message.fromJson(data);
    if (this.widget.userContactedId == receivedMessage.userFromID) {
      messages.insert(1, hisMessage(content: receivedMessage.content));
      if (mounted) setState(() {});
    }
  }

  void instantiateSocketForChat({@required Function onNewMessage}) {
    socket =
        io(SettingsManager.cfg.getString("websocketUrl"), <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('newMessage', (data) => _onNewMessage(data));
    print("socket");
  }

  void emitNewMessage({@required String idReceiver, @required String content}) {
    socket.emit("sendMessage", <String, dynamic>{
      'token': SettingsManager.applicationProperties.getCurrentToken(),
      'data': {
        'content': content,
        'idReceiver': idReceiver,
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppSearchBar(),
        body: FutureBuilder(
          future: _instantiateChatWithAllMessageAndInput(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
          },
        ),
        bottomNavigationBar: BottomNavigationBarFooter(
          selectedBottomIndexOffLine: null,
          selectedBottomIndexOnline: 2,
        ),
      ),
      onWillPop: () async =>
          await updateSettingsPropertyNewMessageLessWithCurrentNewMessageFromThisUserAndRemoveITFromBDD(),
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
                emitNewMessage(
                    idReceiver: this.widget.userContactedId,
                    content: mTextMessageController.text);
                messages.insert(
                  1,
                  myMessage(content: mTextMessageController.text),
                );
                setState(() {
                  mTextMessageController.clear();
                });
              }
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget myMessage({@required content}) {
    return Bubble(
        margin: BubbleEdges.only(top: 10),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftTop,
        child: Wrap(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: SettingsManager.mapLanguage["Me"] + ": ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                    text: content,
                    style: TextStyle(fontSize: 25, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget hisMessage({@required content}) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: Bubble(
              margin: BubbleEdges.only(top: 10),
              nip: BubbleNip.rightTop,
              color: Color.fromRGBO(225, 255, 199, 1.0),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: this.widget.userContactedName + ": ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  children: <TextSpan>[
                    TextSpan(
                      text: content,
                      style: TextStyle(fontSize: 25, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: AvatarSkinWidget.searchConstructor(
                accessoryImage: this.widget.userContactedSkin.accessoryPath,
                faceImage: this.widget.userContactedSkin.facePath,
                skinColor: this.widget.userContactedSkin.skinColor),
          ),
        ],
      ),
    );
  }
}
