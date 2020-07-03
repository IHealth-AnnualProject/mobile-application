import 'package:betsbi/services/global/controller/SearchBarController.dart';
import 'package:betsbi/services/global/model/searchItem.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/relaxing/view/AmbianceView.dart';
import 'package:betsbi/tools/MusicPlayerCardItem.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

import '../../../tools/WaitingWidget.dart';

class SearchMusic extends SearchDelegate<String> {
  List<SearchItem> items;
  AsyncMemoizer _memorizer = AsyncMemoizer();
  final BuildContext context;

  SearchMusic(this.context);

  getSearchList() {
    return this._memorizer.runOnce(() async {
      items = new List<SearchItem>();
      return items = await SearchBarController.getAllMusic(context: context);
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AmbiancePage(),
            ),
            (Route<dynamic> route) => false,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    // data loaded:
    final suggestionList = items;
    return ListView.builder(
      itemBuilder: (context, index) => MusicPlayerCardItem(
          name: items[index].song.songName,
          duration: items[index].song.duration,
          id: items[index].song.id),
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
          _memorizer = AsyncMemoizer();
          final suggestionList = query.isEmpty
              ? items
              : items
                  .where((p) =>
                      p.title.contains(RegExp(query, caseSensitive: false)))
                  .toList();
          return ListView.builder(
            itemBuilder: (context, index) => MusicPlayerCardItem(
              name: suggestionList[index].song.songName,
              id: suggestionList[index].song.id,
              duration: suggestionList[index].song.duration,
            ),
            itemCount: suggestionList.length,
          );
        }
      },
    );
  }
}
