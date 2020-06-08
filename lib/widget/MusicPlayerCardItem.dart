import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:async/async.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/service/FileManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';

class MusicPlayerCardItem extends StatefulWidget {
  final String name;
  final String duration;
  final String id;

  MusicPlayerCardItem({@required this.name, @required this.duration, @required this.id});

  @override
  State<MusicPlayerCardItem> createState() => _MusicPlayerCardItemState();
}

class _MusicPlayerCardItemState extends State<MusicPlayerCardItem> {
  bool isMusicAvailable;
  Duration musicDuration;
  AssetsAudioPlayer assetsAudioPlayer;
  String applicationPath;
  AsyncMemoizer _memorizer = AsyncMemoizer();



  getAllMusic() {
    return this._memorizer.runOnce(() async {
      isMusicAvailable = await FileManager.checkIfFileExist(
          fileName: this.widget.name + ".mp3");
      applicationPath = (await getApplicationDocumentsDirectory()).path;
      if (isMusicAvailable) {
        assetsAudioPlayer = new AssetsAudioPlayer();
        try {
          await assetsAudioPlayer.open(
              Audio.file(
                  applicationPath + "/" + this.widget.name + ".mp3"),
              autoStart: false);
          if (isMusicAvailable) {
            musicDuration = assetsAudioPlayer.current.value.audio.duration;
            String musicDurationToCompare =
                Duration(seconds: musicDuration.inSeconds)
                        .inMinutes
                        .toString() +
                    ":" +
                    Duration(seconds: musicDuration.inSeconds % 60)
                        .inSeconds
                        .toString();
            if (musicDurationToCompare != this.widget.duration) {
              isMusicAvailable = false;
            }
          }
        } on PlatformException catch (e) {
          isMusicAvailable = false;
        } on IOException catch (e) {
          isMusicAvailable = false;
        }
      }
      return isMusicAvailable;
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
    AmbianceController.assetsAudioPlayer.currentPosition.listen((audio) {
      if (AmbianceController.assetsAudioPlayer.isPlaying.value) if (audio
          .inSeconds ==
          AmbianceController
              .assetsAudioPlayer.current.value.audio.duration.inSeconds) {
        AmbianceController.assetsAudioPlayer
            .open(Audio.file(applicationPath +
            "/" +
            this.widget.name +
            ".mp3"),autoStart: false)
            .whenComplete(() => setState(() {}));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.35,
      child: Card(
        elevation: 10,
        child: FutureBuilder(
            future: getAllMusic(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(this.widget.name),
                  onTap: () async => isMusicAvailable
                      ? AmbianceController.listenMusic(
                          songName: this.widget.name,
                          path: applicationPath +
                              "/" +
                              this.widget.name +
                              ".mp3",
                          context: context)
                      : await FileManager.downloadFile(
                              fileName: this.widget.name + ".mp3",
                              musicId: this.widget.id)
                          .whenComplete(() {
                          this.setState(() {
                            _memorizer = AsyncMemoizer();
                          });
                        }),
                  trailing: isMusicAvailable
                      ? Icon(Icons.play_arrow)
                      : Icon(Icons.arrow_downward),
                  subtitle: this.widget.duration != null
                      ? Text(this.widget.duration)
                      : Text(""),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: SettingsManager.mapLanguage["AddToPlaylist"],
          color: Colors.blue,
          icon: Icons.add,
          onTap: () => print("archive"),
        ),
      ],
    );
  }
}
