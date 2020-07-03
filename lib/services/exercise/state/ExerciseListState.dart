import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/exercise/controller/ExerciseController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/exercise/view/ExerciseListView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/EmptyListWidget.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListState extends State<ExerciseListPage>
    with WidgetsBindingObserver {

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
        future: ExerciseController.getListOfExerciseOnlineMode(context: context, type: this.widget.type, leading: this.widget.leading),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: snapshot.data[index],
                  );
                },
              );
            } else
              return EmptyListWidget();
          } else
            return WaitingWidget();
        },
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffLine,
      ),
    );
  }
}
