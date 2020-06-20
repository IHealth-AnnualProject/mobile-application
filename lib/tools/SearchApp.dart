import 'package:betsbi/services/global/controller/SearchBarController.dart';
import 'package:betsbi/services/global/model/searchItem.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class DataSearch extends SearchDelegate<String> {
  List<SearchItem> items;
  AsyncMemoizer _memoizer = AsyncMemoizer();
  final BuildContext context;

  DataSearch(this.context);

  getSearchList() {
    return this._memoizer.runOnce(() async {
      return items = await SearchBarController.getAllPropsAccordingToCategoryChosen(context: context);
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
    final suggestionList = items;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(items[index].title),
        //subtitle: Text(userProfiles[index].type),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    return FutureBuilder(
      future: getSearchList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return WaitingWidget();
        } else {
          // data loaded:
          _memoizer = AsyncMemoizer();
          final suggestionList = query.isEmpty
              ? items
              : items
                  .where((p) =>
                      p.title.contains(RegExp(query, caseSensitive: false)))
                  .toList();
          return ListView.builder(
            itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchBarController.redirectAfterPushing(suggestionList[index]),
                    ),
                  );
                },
                trailing: items[index].trailing,
                subtitle: Text(items[index].subtitle),
                title: RichText(
                  text: TextSpan(
                    text: suggestionList[index]
                        .title
                        .substring(0, query.length),
                    style: TextStyle(
                        color: Color.fromRGBO(0, 157, 153, 1),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: suggestionList[index]
                            .title
                            .substring(query.length),
                        style: TextStyle(
                          color: Color.fromRGBO(0, 157, 153, 1),
                        ),
                      ),
                    ],
                  ),
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
