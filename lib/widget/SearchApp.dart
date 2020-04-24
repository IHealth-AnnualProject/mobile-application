import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<User> users;

  DataSearch(this.users);

  @override
  String get searchFieldLabel => SettingsManager.mapLanguage["SearchContainer"] != null
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
    final suggestionList = users;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(users[index].name),
        subtitle: Text(users[index].type),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final suggestionList = query.isEmpty
        ? users
        : users
            .where((p) => p.name.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(listWordsDetail: suggestionList[index]),
          ),
        ); */
        },
        trailing: Icon(Icons.account_box),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].name.substring(0, query.length),
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].name.substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
