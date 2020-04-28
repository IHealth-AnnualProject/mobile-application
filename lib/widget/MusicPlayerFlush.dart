import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerFlush extends StatefulWidget {
  final String path;
  final String name;
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();


  MusicPlayerFlush({this.path, this.name});

  @override
  _MusicPlayerFlushState createState() => _MusicPlayerFlushState();
}

class _MusicPlayerFlushState extends State<MusicPlayerFlush> {
  bool musicOn;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    musicOn = this.widget.assetsAudioPlayer.isPlaying.value;
    return Flushbar(
      isDismissible: true,
      title: this.widget.name,
      message: "prout",
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        Icons.music_note,
        color: Colors.white,
      ),
      onStatusChanged: (FlushbarStatus status) {
        if (status == FlushbarStatus.SHOWING) {
          this.widget.assetsAudioPlayer.open(Audio(this.widget.path));
        }
        if (status == FlushbarStatus.DISMISSED) {
          this.widget.assetsAudioPlayer.stop();
        }
      },
      mainButton: FlatButton(
        child: Icon(
          musicOn ? Icons.play_arrow : Icons.stop,
          color: Colors.white,
        ),
        onPressed: () {
          this.widget.assetsAudioPlayer.playOrPause();
          setState(() {
          });
        },
      ),
    )..show(context);
  }
}
