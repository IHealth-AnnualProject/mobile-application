import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsManager.languageStarted().then((r) => GlobalConfiguration()
      .loadFromPath("assets/cfg/settings.json")
      .then((r) => runApp(MaterialApp(home: AmbiancePage()))));
}

class AmbiancePage extends StatefulWidget {
  AmbiancePage({Key key}) : super(key: key);

  @override
  _AmbianceView createState() => _AmbianceView();
}

class _AmbianceView extends State<AmbiancePage> {
  //AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  /*Flushbar flushbar() {
    return Flushbar(
      isDismissible: false,
      title: "this.widget.name",
      message: "prout",
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.BOTTOM,
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
          assetsAudioPlayer.isPlaying.value ? Icons.play_arrow : Icons.stop,
          color: Colors.white,
        ),
        onPressed: () {
          assetsAudioPlayer.playOrPause();
          setState(() {

          });
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
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
      appBar: AppSearchBar.AppSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
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
            //flushbar()
          ],
        ),
      )), // Th
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
