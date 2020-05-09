import 'package:async/async.dart';
import 'package:betsbi/controller/SearchBarController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ChatView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListContactPage extends StatefulWidget {
  @override
  _ChatListContactPageState createState() => _ChatListContactPageState();
}

class _ChatListContactPageState extends State<ChatListContactPage>
    with WidgetsBindingObserver {
  List<Widget> list;
  List<User> users;
  AsyncMemoizer _memoizer = AsyncMemoizer();



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    this._memoizer = AsyncMemoizer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  findUsers() {
    return this._memoizer.runOnce(() async {
      users = new List<User>();
      users = await SearchBarController.getAllProfile(context);
      return users;
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

  ListTile userToChatWith({User user}) {
    return ListTile(
      leading: user.isPsy ? Icon(Icons.spa) : Icon(Icons.account_box),
      title: Text(user.username),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(userContacted: user,)),
        );
      },
      subtitle: Text(user.isPsy
          ? SettingsManager.mapLanguage["PsyChoice"]
          : SettingsManager.mapLanguage["UserChoice"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: FutureBuilder(
        future: findUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            // data loaded:
            return ListView.builder(
              itemBuilder: (context, index) => Card(
                child: userToChatWith(user: users[index]),
              ),
              itemCount: users.length,
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
