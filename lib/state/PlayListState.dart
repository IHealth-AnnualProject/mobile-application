import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/PlayListController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/song.dart';
import 'package:betsbi/service/FileManager.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/PlayListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/EmptyListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';

class PlayListState extends State<PlayListPage> with WidgetsBindingObserver {
  String applicationPath;
  List<Song> songs;
  List<Audio> audios;

  Future<bool> checkIfSongIsAvailable({String songName, String songDuration, int index}) async {
      applicationPath = (await getApplicationDocumentsDirectory()).path;
        bool isAvailable = await AmbianceController.checkIfSongAvailable(
            songName: songName, duration: songDuration);
        print("here");
           _fromSongsToPath(
            index: index, songName: songName, isAvailable: isAvailable);
      return isAvailable;
  }

  void _fromSongsToPath({bool isAvailable, String songName, int index}) {
    print("index " + index.toString());
    print("length" + audios.length.toString());
    print(isAvailable);
    if (isAvailable)
      audios.insert(index,Audio.file(applicationPath + "/" + songName + ".mp3"));
  }

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
    songs = this.widget.playList.songs;
    audios = new List<Audio>();
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
            songs.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => musicPlayerPlayListInItem(
                        index: index, song: songs[index]),
                    itemCount: songs.length,
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
          future: checkIfSongIsAvailable(
              songName: song.songName, songDuration: song.duration, index : index),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListTile(
                leading: Icon(Icons.music_note),
                title: Text(song.songName),
                onTap: () async => snapshot.data
                    ? await AmbianceController.listenMusic(
                        songName: this.widget.playList.name,
                        paths: audios,
                        startAtIndex: index,
                        context: context)
                    : await FileManager.downloadFile(
                        fileName: song.songName + ".mp3",
                        musicId: song.id,
                        context: context,
                      ).whenComplete(() {
                        setState(() {
                        });
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
              songs.removeAt(index);
              audios = new List<Audio>();
            }),
          ),
        ),
      ],
    );
  }
}
