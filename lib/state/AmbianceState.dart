import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/view/RelaxingView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/MusicPlayerCardItem.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmbianceState extends State<AmbiancePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  List<Widget> list;
  Animation<double> _animation;
  AnimationController _animationController;

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
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (HistoricalManager.historical.last.toString() != this.widget.toString())
      HistoricalManager.historical.add(this.widget);
    list = new List<Widget>();
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
    print(HistoricalManager.historical);
    final titleAmbiance = Text(
      SettingsManager.mapLanguage["RelaxingMusic"] != null
          ? SettingsManager.mapLanguage["RelaxingMusic"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return Scaffold(
      appBar: AppSearchBar(),
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
      floatingActionButton: FloatingActionBubble(
        animation: _animation,
        iconColor: Colors.blue,
        icon: AnimatedIcons.ellipsis_search,
        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();
        },
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
              _animationController.reverse();
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => RelaxingView(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
