import 'package:betsbi/controller/ExerciseController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListViewState extends State<ExerciseListViewPage>
    with WidgetsBindingObserver {
  List<Widget> list;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    list = new List<Widget>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: this.widget.isOffLine,
      ),
      body: FutureBuilder(
        future: ExerciseController.getJsonAccodingToExerciseType(
            context: context, type: this.widget.type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ExerciseController.decodeJsonAndStoreItInsideExerciseList(
                snapshot.data.toString(),
                list,
                this.widget.leading,
                context,
                this.widget.isOffLine);
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
        null,
        isOffLine: this.widget.isOffLine,
      ),
    );
  }
}
