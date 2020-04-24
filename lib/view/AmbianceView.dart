import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/MusicPlayerFlush.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbiancePage extends StatefulWidget {
  AmbiancePage({Key key}) : super(key: key);

  @override
  AmbianceView createState() => AmbianceView();
}

class AmbianceView extends State<AmbiancePage> {
  int _selectedBottomIndex = 1;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  MusicPlayerFlush flush;
  bool musicOn;


  //MusicPlayer musicPlayer;

  void instanciateLanguage() async {
    await SettingsManager.languageStarted();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    instanciateLanguage();
    musicOn = assetsAudioPlayer.isPlaying.value;
    final buttonMusic = RaisedButton(
        onPressed: () => Flushbar(
          isDismissible: true,
          title: "this.widget.name",
          message: "prout",
          flushbarStyle: FlushbarStyle.GROUNDED,
          icon: Icon(
            Icons.music_note,
            color: Colors.white,
          ),
          onStatusChanged: (FlushbarStatus status) {
            if (status == FlushbarStatus.SHOWING) {
              assetsAudioPlayer.open(Audio("assets/audio/song1.mp3"));
            }
            if (status == FlushbarStatus.DISMISSED) {
              assetsAudioPlayer.stop();
            }
          },
          mainButton: FlatButton(
            child: Icon(
              musicOn ? Icons.play_arrow : Icons.stop,
              color: Colors.white,
            ),
            onPressed: () {
              assetsAudioPlayer.playOrPause();
              setState(() {
              });
            },
          ),
        )..show(context)

    );
    final titleAccount = Text(
      SettingsManager.mapLanguage["RelaxingMusic"] != null
          ? SettingsManager.mapLanguage["RelaxingMusic"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(104, 79, 37, 0.8),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar(
          SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          ContainerController.users),
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage("assets/notes.png"),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleAccount,
            buttonMusic,
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }
}
