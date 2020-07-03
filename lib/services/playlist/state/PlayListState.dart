import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/manager/FileManager.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/playlist/model/song.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/services/playlist/controller/PlayListController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/playlist/view/PlayListView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/EmptyListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PlayListState extends State<PlayListPage> with WidgetsBindingObserver {

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
    PlayListController.songs = new List<Song>();
    PlayListController.songs.addAll(this.widget.playList.songs);
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
  Widget build(BuildContext context) {
    PlayListController.audios = new List<Audio>();
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DefaultTextTitle(
              title: this.widget.playList.name,
            ),
            SizedBox(
              height: 45,
            ),
            PlayListController.songs.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => musicPlayerPlayListInItem(
                        index: index, song: PlayListController.songs[index]),
                    itemCount: PlayListController.songs.length,
                  )
                : EmptyListWidget(),
          ],
        ),
      ),
    );
  }

  Slidable musicPlayerPlayListInItem({int index, Song song}) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.35,
      child: Card(
        elevation: 10,
        child: FutureBuilder(
          future: PlayListController.checkIfSongIsAvailable(
              songName: song.songName,
              songDuration: song.duration,
              index: index),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListTile(
                leading: Icon(Icons.music_note),
                title: Text(song.songName),
                onTap: () async => snapshot.data
                    ? await AmbianceController.listenMusic(
                        songName: this.widget.playList.name,
                        paths: PlayListController.audios,
                        startAtIndex: index,
                        context: context)
                    : await FileManager.downloadFile(
                        fileName: song.songName + ".mp3",
                        musicId: song.id,
                        context: context,
                      ).whenComplete(() {
                        setState(() {});
                      }),
                trailing: snapshot.data
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.arrow_downward),
                subtitle:
                    song.duration != null ? Text(song.duration) : Text(""),
              );
            } else {
              return Container(
                color: Colors.grey,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: SettingsManager.mapLanguage["RemoveFromPlaylist"],
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async => await PlayListController.removeSongFromPlayList(
                  context: context,
                  playlistId: this.widget.playList.id,
                  musicId: song.id)
              .whenComplete(
            () => setState(() {
              PlayListController.songs.removeAt(index);
            }),
          ),
        ),
      ],
    );
  }
}
