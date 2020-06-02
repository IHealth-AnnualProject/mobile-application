import 'package:betsbi/controller/LessonController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/LessonListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonListState extends State<LessonListView> {
  List<Widget> list;

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
            return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        null,
        isOffLine: this.widget.isOffLine,
      ),
    );
  }
}
