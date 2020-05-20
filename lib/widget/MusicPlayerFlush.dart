import 'package:betsbi/state/AmbianceState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerFlush extends StatefulWidget {
  final AmbianceState parent;

  MusicPlayerFlush({this.parent});


  @override
  MusicPlayerFlushState createState() => MusicPlayerFlushState();
}

class MusicPlayerFlushState extends State<MusicPlayerFlush> {

  @override
  Widget build(BuildContext context) {
    this.widget.parent.assetsAudioPlayer.playOrPause();
    return FlatButton(
      child: Icon(
        this.widget.parent.assetsAudioPlayer.isPlaying.value ? Icons.play_arrow : Icons.pause,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {});
      },
    );
  }

}
