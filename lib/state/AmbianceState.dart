import 'package:betsbi/animation/CurvedAnimation.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/view/RelaxingView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultCircleAvatar.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/MusicPlayerCardItem.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbianceState extends State<AmbiancePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  List<Widget> list = new List<Widget>();
  CustomCurvedAnimation curvedAnimation;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (AmbianceController.musicFlush != null &&
        AmbianceController.musicFlush.isShowing())
      AmbianceController.musicFlush.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    curvedAnimation = CustomCurvedAnimation.withCurve(
        vsync: this,
        duration: Duration(milliseconds: 260),
        begin: 0,
        end: 1,
        curves: Curves.easeInOut);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    list.add(
      MusicPlayerCardItem(
        artistName: "Monsieur TOEIC",
        songName: "Song 1",
        path: "assets/audio/song1.mp3",
      ),
    );
    if (AmbianceController.song.isOpen()) {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
            ),
            DefaultCircleAvatar(
              imagePath: "assets/exercise.png",
            ),
            SizedBox(
              height: 45,
            ),
            DefaultTextTitle(
              title: SettingsManager.mapLanguage["RelaxingMusic"],
            ),
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
      floatingActionButton: FloatingActionBubble(
        animation: curvedAnimation.animation,
        iconColor: Colors.blue,
        icon: AnimatedIcons.ellipsis_search,
        onPress: () => curvedAnimation.startAnimation(),
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "PlayLists",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.list,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () => curvedAnimation.animationController.reverse(),
          ),
          // Floating action menu item
          Bubble(
              title: SettingsManager.mapLanguage["RelaxingColor"],
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.spa,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelaxingView(),
                    ),
                    (Route<dynamic> route) => false,
                  )),
        ],
      ),
    );
  }
}
