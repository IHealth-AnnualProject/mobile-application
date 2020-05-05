import 'package:betsbi/controller/SearchBarController.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class DataSearch extends SearchDelegate<String> {
  List<UserProfile> userProfiles;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  DataSearch();

  findUsers() {
    return this._memoizer.runOnce(() async {
      userProfiles = new List<UserProfile>();
      userProfiles = await SearchBarController.getAllUserProfile();
      return userProfiles;
    });
  }

  @override
  String get searchFieldLabel =>
      SettingsManager.mapLanguage["SearchContainer"] != null
          ? SettingsManager.mapLanguage["SearchContainer"]
          : "";

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    // data loaded:
    final suggestionList = userProfiles;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(userProfiles[index].username),
        //subtitle: Text(userProfiles[index].type),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    return FutureBuilder(
      future: findUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          // data loaded:
          final suggestionList = query.isEmpty
              ? userProfiles
              : userProfiles
                  .where((p) =>
                      p.username.contains(RegExp(query, caseSensitive: false)))
                  .toList();
          return ListView.builder(
            itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountPage(
                          isPsy: SettingsManager.isPsy.toLowerCase() == 'true'
                              ? true
                              : false,
                          userId: suggestionList[index].userProfileId),
                    ),
                  );
                },
                trailing: userProfiles[index].isPsy
                    ? Icon(Icons.spa)
                    : Icon(Icons.account_box),
                subtitle: userProfiles[index].isPsy
                    ? Text(SettingsManager.mapLanguage["PsyChoice"])
                    : Text(SettingsManager.mapLanguage["UserChoice"]),
                title: RichText(
                  text: TextSpan(
                      text: suggestionList[index]
                          .username
                          .substring(0, query.length),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: suggestionList[index]
                                .username
                                .substring(query.length),
                            style: TextStyle(color: Colors.grey)),
                      ]),
                ),
              ),
            ),
            itemCount: suggestionList.length,
          );
        }
      },
    );
  }
}
