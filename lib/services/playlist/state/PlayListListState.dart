import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/playlist/controller/PlayListController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/playlist/view/PlayListListView.dart';
import 'package:betsbi/services/playlist/view/PlayListView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/EmptyListWidget.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:betsbi/tools/TextFormFieldCustomBetsBi.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListListState extends State<PlayListListPage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController playListNameController = TextEditingController();

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
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
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
                                  playListName:
                                      playListNameController.value.text)
                              .whenComplete(
                            () => setState(
                              () {
                                playListNameController.clear();
                              },
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            DefaultTextTitle(
              title: "PlayList",
            ),
            FutureBuilder(
              future: PlayListController.getAllPlayList(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.isNotEmpty
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text(snapshot.data[index].name),
                              onTap: () {
                                if (AmbianceController.musicFlush != null)
                                  AmbianceController.musicFlush.dismiss();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayListPage(
                                      playList: snapshot.data[index],
                                    ),
                                  ),
                                ).whenComplete(
                                  () {
                                    if (AmbianceController
                                        .assetsAudioPlayer.isPlaying.value) {
                                      AmbianceController.musicFlush
                                          .dismiss()
                                          .whenComplete(() =>
                                              AmbianceController.musicFlush
                                                ..show(context));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          itemCount: snapshot.data.length,
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
