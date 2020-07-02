import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/lesson/controller/LessonController.dart';
import 'package:betsbi/services/lesson/view/LessonListView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonListState extends State<LessonListPage> with WidgetsBindingObserver {
  List<Widget> listLesson;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !this.widget.isOffLine) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    listLesson = new List<Widget>();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: this.widget.isOffLine,
      ),
      body: FutureBuilder(
        future: LessonController.getJsonLesson(context: context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LessonController.decodeJsonAndStoreItInsideLessonList(
                snapshot.data.toString(), listLesson, context);
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listLesson.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: listLesson[index],
                );
              },
            );
          } else
            return WaitingWidget();
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: 0, selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffLine,
      ),
    );
  }
}
