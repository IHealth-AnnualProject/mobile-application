import 'package:betsbi/animation/CurvedAnimation.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/relaxing/view/AmbianceView.dart';
import 'package:betsbi/services/playlist/view/PlayListListView.dart';
import 'package:betsbi/services/relaxing/view/RelaxingView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/SearchMusic.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbianceState extends State<AmbiancePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CustomCurvedAnimation curvedAnimation;

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
    curvedAnimation = CustomCurvedAnimation.withCurve(
        vsync: this,
        duration: Duration(milliseconds: 260),
        begin: 0,
        end: 1,
        curves: Curves.easeInOut);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    if (AmbianceController.assetsAudioPlayer.isPlaying.value) {
      AmbianceController.musicFlush
          .dismiss()
          .whenComplete(() => AmbianceController.musicFlush..show(context));
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
      body: FutureBuilder(
        future: AmbianceController.getAllMusic(context: context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 10,
                    child: ListTile(
                      title:
                          Text(SettingsManager.mapLanguage["SearchContainer"]),
                      trailing: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SearchMusic(context),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    SettingsManager.mapLanguage["AllMusicAvailable"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index];
                    },
                  )
                ],
              ),
            );
          } else
            return WaitingWidget();
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
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
            onPress: () {
              if (AmbianceController.musicFlush != null)
                AmbianceController.musicFlush.dismiss();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayListListPage(),
                ),
              ).then((_) {
                if (AmbianceController.assetsAudioPlayer.isPlaying.value) {
                  AmbianceController.musicFlush.dismiss().whenComplete(
                      () => AmbianceController.musicFlush..show(context));
                }
                this.setState(() {curvedAnimation.animationController.reverse();});
              });
            },
          ),
          // Floating action menu item
          Bubble(
            title: SettingsManager.mapLanguage["RelaxingColor"],
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.spa,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              if (AmbianceController.musicFlush != null)
                AmbianceController.musicFlush.dismiss();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RelaxingPage(),
                ),
              ).whenComplete(
                () => setState(() {}),
              );
            },
          ),
        ],
      ),
    );
  }
}
