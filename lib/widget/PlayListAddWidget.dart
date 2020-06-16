import 'package:async/async.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/PlayListListView.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/NothingToShow.dart';
import 'package:flutter/cupertino.dart';
import 'package:betsbi/controller/PlayListController.dart';
import 'package:flutter/material.dart';

class PlayListAddWidget extends StatefulWidget {
  final String songName;
  final String songId;
  final String songDuration;

  PlayListAddWidget(
      {@required this.songName,
      @required this.songId,
      @required this.songDuration});

  @override
  State<PlayListAddWidget> createState() => _PlayListAddState();
}

class _PlayListAddState extends State<PlayListAddWidget> {
  AsyncMemoizer _memorizer = AsyncMemoizer();
  List<PlayList> playLists;
  PlayList firstValueOfPlayLists;

  getAllPlayList({BuildContext context}) {
    return this._memorizer.runOnce(() async {
      playLists = await PlayListController.getAllPlayList(context: context);
      firstValueOfPlayLists = playLists.isNotEmpty ? playLists.first : null;
      return playLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DefaultTextTitle(
        title: SettingsManager.mapLanguage["AddThisSongToYourPlayList"],
      ),
      content: FutureBuilder(
        future: getAllPlayList(context: context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return playLists.isNotEmpty
                ? DropdownButton<PlayList>(
                    value: firstValueOfPlayLists,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (PlayList newValue) {
                      setState(() {
                        firstValueOfPlayLists = newValue;
                      });
                    },
                    items: playLists
                        .map<DropdownMenuItem<PlayList>>((PlayList value) {
                      return DropdownMenuItem<PlayList>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  )
                : NothingToShow(
                    destination: PlayListListPage(),
                  );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
            child: Text(SettingsManager.mapLanguage["Submit"]),
            onPressed: () async {
              await PlayListController.addSongToPlayList(
                context: context,
                playlistId: firstValueOfPlayLists.id,
                musicId: this.widget.songId,
              );
              await AmbianceController.checkSongAndDownload(
                context: context,
                songName: this.widget.songName,
                duration: this.widget.songDuration,
                id: this.widget.songId,
              ).whenComplete(
                    () => setState(() { _memorizer = new AsyncMemoizer(); }),
              );
            }),
        FlatButton(
          child: Text(SettingsManager.mapLanguage["Cancel"]),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
