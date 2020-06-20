import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:async/async.dart';
import 'package:betsbi/manager/FileManager.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/tools/PlayListAddWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';

class MusicPlayerCardItem extends StatefulWidget {
  final String name;
  final String duration;
  final String id;

  MusicPlayerCardItem(
      {@required this.name, @required this.duration, @required this.id});

  @override
  State<MusicPlayerCardItem> createState() => _MusicPlayerCardItemState();
}

class _MusicPlayerCardItemState extends State<MusicPlayerCardItem> {
  Duration musicDuration;
  AssetsAudioPlayer assetsAudioPlayer;
  String applicationPath;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  checkIfSongIsAvailable() {
    return this._memorizer.runOnce(() async {
      applicationPath = (await getApplicationDocumentsDirectory()).path;
      return await AmbianceController.checkIfSongAvailable(
          songName: this.widget.name, duration: this.widget.duration);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _memorizer = AsyncMemoizer();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.35,
      child: Card(
        elevation: 10,
        child: FutureBuilder(
            future: checkIfSongIsAvailable(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(this.widget.name),
                  onTap: () async => snapshot.data
                      ? AmbianceController.listenMusic(
                          songName: this.widget.name,
                          paths: [Audio.file(applicationPath + "/" + this.widget.name + ".mp3")],
                          context: context)
                      : await FileManager.downloadFile(
                          fileName: this.widget.name + ".mp3",
                          musicId: this.widget.id,
                          context: context,
                        ).whenComplete(() {
                          setState(() {
                            _memorizer = AsyncMemoizer();
                          });
                        }),
                  trailing: snapshot.data
                      ? Icon(Icons.play_arrow)
                      : Icon(Icons.arrow_downward),
                  subtitle: this.widget.duration != null
                      ? Text(this.widget.duration)
                      : Text(""),
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
            }),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: SettingsManager.mapLanguage["AddToPlaylist"],
          color: Colors.blue,
          icon: Icons.add,
          onTap: () async => await _addToPlayList(),
        ),
      ],
    );
  }

  Future<void> _addToPlayList() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlayListAddWidget(
          songName: this.widget.name,
          songId: this.widget.id,
          songDuration: this.widget.duration,
        );
      },
    );
  }
}
