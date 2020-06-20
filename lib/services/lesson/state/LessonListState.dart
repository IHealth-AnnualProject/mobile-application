import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/lesson/controller/LessonController.dart';
import 'package:betsbi/services/lesson/view/LessonListView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonListState extends State<LessonListPage> {
  List<Widget> list;

  //todo add on resume

  @override
  void initState() {
    super.initState();
    list = new List<Widget>();
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
                snapshot.data.toString(), list, context);
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: list[index],
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
