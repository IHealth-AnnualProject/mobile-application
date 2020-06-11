import 'package:async/async.dart';
import 'package:betsbi/controller/ExerciseController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/EmptyListWidget.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListViewStateOffline extends State<ExerciseListViewPage>
    with WidgetsBindingObserver {
  List<Widget> listExercise;
  final AsyncMemoizer _memorizer = AsyncMemoizer();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    listExercise = new List<Widget>();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !this.widget.isOffLine) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }


  getAllExercise() {
    return this._memorizer.runOnce(() async {
      return listExercise = await ExerciseController.getAllJsonAndRecoverListOfExercise(context: context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: this.widget.isOffLine,
      ),
      body: FutureBuilder(
        future: getAllExercise(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (listExercise.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: listExercise.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: listExercise[index],
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
        2,
        isOffLine: this.widget.isOffLine,
      ),
    );
  }
}
