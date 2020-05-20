import 'package:betsbi/state/AmbianceState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerButtonPlay extends StatefulWidget {
  final AmbianceState parent;

  MusicPlayerButtonPlay({this.parent});


  @override
  MusicPlayerFlushState createState() => MusicPlayerFlushState();
}

class MusicPlayerFlushState extends State<MusicPlayerButtonPlay> {

  @override
  Widget build(BuildContext context) {
    this.widget.parent.assetsAudioPlayer.playOrPause();
    return FlatButton(
      color: Color.fromRGBO(0, 157, 153, 1),
      child: Icon(
        this.widget.parent.assetsAudioPlayer.isPlaying.value ? Icons.play_arrow : Icons.pause,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
        });
      },
    );
  }

}
