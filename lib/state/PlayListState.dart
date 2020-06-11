import 'package:async/async.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/PlayListController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/model/song.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/PlayListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/EmptyListWidget.dart';
import 'package:betsbi/widget/MusicPlayerCardItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListState extends State<PlayListPage> with WidgetsBindingObserver {
  final AsyncMemoizer _memorizer = AsyncMemoizer();
  List<Song> songs;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (AmbianceController.musicFlush != null &&
        AmbianceController.musicFlush.isShowing())
      AmbianceController.musicFlush.dismiss();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    if (AmbianceController.assetsAudioPlayer.isPlaying.value) {
      AmbianceController.musicFlush
          .dismiss()
          .then((value) => AmbianceController.musicFlush..show(context));
    }

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  getAllSongsOfPlayList() {
    return this._memorizer.runOnce(() async {
      PlayList playList = await PlayListController.getPlayList(
          context: context, playListId: this.widget.playList.id);
      songs = playList.songs;
      return songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(null),
      body: Column(
        children: <Widget>[
          DefaultTextTitle(
            title: this.widget.playList.name,
          ),
          songs.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) => MusicPlayerCardItem(
                    duration: songs[index].duration,
                    name: songs[index].songName,
                    id: songs[index].id,
                  ),
                  itemCount: songs.length,
                )
              : EmptyListWidget(),
        ],
      ),
    );
  }
}
