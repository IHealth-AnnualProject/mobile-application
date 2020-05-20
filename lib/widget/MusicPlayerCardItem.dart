import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/state/AmbianceState.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MusicPlayerButtonPlay.dart';
import 'MusicPlayerProgressIndicator.dart';

class MusicPlayerCardItem extends StatelessWidget {
  final String songName;
  final Icon icon;
  final String artistName;
  final AmbianceState parent;
  final String path;
  Flushbar flushBarMusic;

  MusicPlayerCardItem(
      {@required this.songName,
      this.artistName,
      @required this.parent,
      @required this.path,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null ? Icon(Icons.spa) : icon,
      title: Text(songName),
      onTap: () {
        if (flushBarMusic != null && flushBarMusic.isShowing())
          flushBarMusic.dismiss();
        flushBar().show(context);
      },
      trailing: Icon(Icons.play_arrow),
      subtitle: this.artistName != null ? Text(artistName) : Text(""),
    );
  }

  Flushbar flushBar() {
    return flushBarMusic = Flushbar<String>(
      backgroundColor: Colors.white,
      isDismissible: true,
      titleText: Text(
        this.songName,textAlign: TextAlign.center,
        style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1)),
      ),
      messageText: MusicPlayerProgressIndicator(
        parent: this.parent,
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        Icons.music_note,
        color: Color.fromRGBO(0, 157, 153, 1),
      ),
      onStatusChanged: (FlushbarStatus status) {
        if (status == FlushbarStatus.SHOWING) {
          this.parent.assetsAudioPlayer.open(
                Audio(this.path),
              );
        }
        if (status == FlushbarStatus.DISMISSED) {
          this.parent.assetsAudioPlayer.stop();
        }
      },
      mainButton: MusicPlayerButtonPlay(
        parent: this.parent,
      ),
    );
  }
}
