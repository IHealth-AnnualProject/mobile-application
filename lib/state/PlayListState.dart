import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/PlayListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/EmptyListWidget.dart';
import 'package:betsbi/widget/MusicPlayerCardItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListState extends State<PlayListPage> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (AmbianceController.musicFlush != null &&
        AmbianceController.musicFlush.isShowing())
      AmbianceController.musicFlush.dismiss();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    if (AmbianceController.assetsAudioPlayer.isPlaying.value) {
      AmbianceController.musicFlush
          .dismiss()
          .then((value) => AmbianceController.musicFlush..show(context));
    }
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
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(null),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DefaultTextTitle(
              title: this.widget.playList.name,
            ),
            SizedBox(height: 45,),
            this.widget.playList.songs.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => MusicPlayerCardItem(
                      duration: this.widget.playList.songs[index].duration,
                      name: this.widget.playList.songs[index].songName,
                      id: this.widget.playList.songs[index].id,
                    ),
                    itemCount: this.widget.playList.songs.length,
                  )
                : EmptyListWidget(),
          ],
        ),
      ),
    );
  }
}
