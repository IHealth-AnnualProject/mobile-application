import 'package:async/async.dart';
import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/PlayListController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/PlayListListView.dart';
import 'package:betsbi/view/PlayListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/EmptyListWidget.dart';
import 'package:betsbi/widget/SubmitButton.dart';
import 'package:betsbi/widget/TextFormFieldCustomBetsBi.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListListState extends State<PlayListListPage>
    with WidgetsBindingObserver {
  final AsyncMemoizer _memorizer = AsyncMemoizer();
  List<PlayList> playLists;
  final _formKey = GlobalKey<FormState>();
  final playListNameController = TextEditingController();

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

  getAllPlayList() {
    return this._memorizer.runOnce(() async {
      playLists = await PlayListController.getAllPlayList(context: context);
      return playLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(null),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 7,
                    child: TextFormFieldCustomBetsBi(
                      obscureText: false,
                      controller: playListNameController,
                      textAlign: TextAlign.left,
                      validator: (value) => CheckController.checkField(value),
                      labelText: SettingsManager.mapLanguage["PlayListText"],
                      filled: true,
                      fillColor: Colors.white,
                      hintText: SettingsManager.mapLanguage["PlayListText"],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: SubmitButton(
                      content: SettingsManager.mapLanguage["Submit"],
                      onPressedFunction: () async {
                        if (this._formKey.currentState.validate()) {
                          await PlayListController.createNewPlayList(
                              context: context,
                              playListName: playListNameController.value.text);
                          setState(() {});
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            DefaultTextTitle(title: "PlayList",),
            FutureBuilder(
              future: getAllPlayList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return playLists.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text(playLists[index].name),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayListPage(
                                    playList: playLists[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemCount: playLists.length,
                        )
                      : EmptyListWidget();
                } else {
                  return WaitingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
