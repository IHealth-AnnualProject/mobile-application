import 'package:betsbi/controller/AmbianceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerButtonPlay extends StatefulWidget {
  MusicPlayerButtonPlay();

  @override
  MusicPlayerFlushState createState() => MusicPlayerFlushState();
}

class MusicPlayerFlushState extends State<MusicPlayerButtonPlay> {
  bool isPlaying = AmbianceController.song.open;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: StadiumBorder(),
      color: Color.fromRGBO(0, 157, 153, 1),
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
      ),
      onPressed: () {
        AmbianceController.assetsAudioPlayer
            .playOrPause()
            .then((value) => setState(() {
                  isPlaying =
                      AmbianceController.assetsAudioPlayer.isPlaying.value;
                }));
      },
    );
  }
}
