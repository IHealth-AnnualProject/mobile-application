import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/MusicPlayerCardItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbianceState extends State<AmbiancePage> with WidgetsBindingObserver {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  List<Widget> list;

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
    list = new List<Widget>();
    list.add(
      MusicPlayerCardItem(
        parent: this,
        artistName: "Monsieur TOEIC",
        songName: "Song 1",
        path: "assets/audio/song1.mp3",
      ),
    );
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
    final titleAmbiance = Text(
      SettingsManager.mapLanguage["RelaxingMusic"] != null
          ? SettingsManager.mapLanguage["RelaxingMusic"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
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
                  image: AssetImage("assets/exercise.png"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleAmbiance,
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return list[index];
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
