import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseListViewState extends State<ExerciseListViewPage>
    with WidgetsBindingObserver {
  VideoPlayerController _controller;
  List<Widget> list;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _controller.dispose();

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
    list = new List<Widget>();
    switch (this.widget.type) {
      case "Math":
        list.add(
          exercise(
              title: "test",
              leading: this.widget.leading,
              type: SettingsManager.mapLanguage["ExerciseMath"]),
        );
        break;
      case "Emergency":
        list.add(
          exercise(
              title: "test",
              leading: this.widget.leading,
              type: SettingsManager.mapLanguage["ExerciseEmergency"]),
        );
        break;
      case "Muscle":
        list.add(
          exercise(
              title: "test",
              leading: this.widget.leading,
              type: SettingsManager.mapLanguage["ExercisePhysical"]),
        );
        break;
    }
    _controller = VideoPlayerController.network(
        'http://techslides.com/demos/sample-videos/small.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  ListTile exercise({@required String leading, String title, String type}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(leading),
      ),
      title: Text(title),
      onTap: () {
        showAlertDialog(context);
        _controller.play();
      },
      subtitle: Text(type),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: list[index],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}