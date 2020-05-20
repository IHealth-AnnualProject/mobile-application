import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/MusicPlayerButtonPlay.dart';
import 'package:betsbi/widget/MusicPlayerProgressIndicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbianceState extends State<AmbiancePage> with WidgetsBindingObserver {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool musicOn = false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    assetsAudioPlayer.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleAccount = Text(
      SettingsManager.mapLanguage["RelaxingMusic"] != null
          ? SettingsManager.mapLanguage["RelaxingMusic"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(0, 157, 153, 1),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 40.0,
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/notes.png"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleAccount,
            RaisedButton(
              elevation: 8,
              shape: StadiumBorder(),
              color: Color.fromRGBO(255, 195, 0, 1),
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                flushbar().show(context);
              },
              child: Text(
                SettingsManager.mapLanguage["LoginText"] != null
                    ? SettingsManager.mapLanguage["LoginText"]
                    : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 100),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ), // Th
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }

  Flushbar flushbar() {
    return Flushbar<String>(
      isDismissible: true,
      title: "song1",
      messageText: MusicPlayerProgressIndicator(
        parent: this,
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        Icons.music_note,
        color: Colors.white,
      ),
      onStatusChanged: (FlushbarStatus status) {
        if (status == FlushbarStatus.SHOWING) {
          this.assetsAudioPlayer.open(
                Audio(
                  "assets/audio/song1.mp3",
                ),
              );
        }
        if (status == FlushbarStatus.DISMISSED) {
          this.assetsAudioPlayer.stop();
        }
      },
      mainButton: MusicPlayerButtonPlay(
        parent: this,
      ),
    );
  }
}
