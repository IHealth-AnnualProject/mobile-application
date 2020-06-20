import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/exercise/controller/ExerciseController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/view/ExerciseView.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LogicExerciseState extends State<ExercisePage> with WidgetsBindingObserver {
  List<Widget> listCaseExercise =
      new List<Widget>.generate(36, (i) => Container());
  bool isCongratsHidden = false;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !this.widget.isOffline) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    WidgetsBinding.instance.addObserver(this);
    ExerciseController.createListWidgetOverMapString(
        exercise: this.widget.exercise,
        logicExerciseState: this,
        listCasePipeGame: listCaseExercise);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: this.widget.isOffline,
      ),
      body: Column(
        children: <Widget>[
          DefaultTextTitle(title: SettingsManager.mapLanguage["PipeGameExplanation"],),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black87),
                left: BorderSide(width: 1.0, color: Colors.black87),
                right: BorderSide(width: 1.0, color: Colors.black87),
                bottom: BorderSide(width: 1.0, color: Colors.black87),
              ),
            ),
            height: 360,
            width: 360,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: listCaseExercise.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 375),
                columnCount: 6,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Card(
                      child: listCaseExercise[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: isCongratsHidden,
            child: Text(SettingsManager.mapLanguage["Congratulations"],
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 30)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: 0, selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffline,
      ),
    );
  }

  void checkMapEquality() {
    setState(() {
      if (mapEquals(
          this.widget.exercise.inputPipe, this.widget.exercise.outputPipe)) {
        isCongratsHidden = true;
      } else
        isCongratsHidden = false;
    });
  }
}
