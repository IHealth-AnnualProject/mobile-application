import 'package:betsbi/state/AmbianceState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerProgressIndicator extends StatefulWidget {
  final AmbianceState parent;

  MusicPlayerProgressIndicator({this.parent});

  @override
  MusicPlayerProgressIndicatorState createState() =>
      MusicPlayerProgressIndicatorState();
}

class MusicPlayerProgressIndicatorState
    extends State<MusicPlayerProgressIndicator> {
  Duration actualValue = new Duration();
  Duration maxValue = new Duration();

  @override
  void initState() {
    super.initState();
    this.widget.parent.assetsAudioPlayer.onReadyToPlay.listen((audio) {
      setState(() {
        maxValue =
            this.widget.parent.assetsAudioPlayer.current.value.audio.duration;
      });
    });
    this.widget.parent.assetsAudioPlayer.currentPosition.listen((audio) {
      setState(() {
        actualValue = audio;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        value: actualValue.inSeconds.toDouble(),
        min: 0.0,
        max: maxValue.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            this
                .widget
                .parent
                .assetsAudioPlayer
                .seek(Duration(seconds: value.floor()));
          });
        },
      ),
    );
  }
}
