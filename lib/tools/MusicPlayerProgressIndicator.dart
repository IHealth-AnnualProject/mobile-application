import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerProgressIndicator extends StatefulWidget {
  MusicPlayerProgressIndicator();

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
    AmbianceController.assetsAudioPlayer.onReadyToPlay.listen((audio) {
      if (mounted) {
        setState(() {
          maxValue =
              AmbianceController.assetsAudioPlayer.current.value.audio.duration;
        });
      }
    });
    AmbianceController.assetsAudioPlayer.currentPosition.listen((audio) {
      if (mounted) {
        setState(() {
          actualValue = audio;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        value: actualValue.inSeconds.toDouble() != null ? actualValue.inSeconds.toDouble() : 0 ,
        min: 0.0,
        max: maxValue.inSeconds.toDouble() != null ? maxValue.inSeconds.toDouble() : 0,
        onChanged: (double value) {
          setState(() {
            AmbianceController.assetsAudioPlayer
                .seek(Duration(seconds: value.floor()));
          });
        },
      ),
    );
  }
}
