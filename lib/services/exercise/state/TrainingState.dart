import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';

import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/view/ExerciseListView.dart';
import 'package:betsbi/services/exercise/view/TrainingView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/services/exercise/widget/ExercisePresentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainingState extends State<TrainingPage> with WidgetsBindingObserver {
  int _trainIndex = 0;

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
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  RaisedButton choiceExerciseButton({String text, int index}) {
    return RaisedButton(
      elevation: 8,
      color: Color.fromRGBO(255, 195, 0, 1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        setState(() {
          _trainIndex = index;
        });
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: IndexedStack(
              index: _trainIndex,
              children: <Widget>[
                ExercisePresentation(
                  destination: ExerciseListPage(
                    type: "Math",
                    leading: "assets/math.png",
                  ),
                  contentComponent: SettingsManager.mapLanguage["ExerciseMath"],
                  titleComponent:
                      SettingsManager.mapLanguage["MathExplanation"],
                  leadingComponent: "assets/math.png",
                ),
                ExercisePresentation(
                  titleComponent:
                      SettingsManager.mapLanguage["ExercisePhysical"],
                  contentComponent:
                      SettingsManager.mapLanguage["TrainingExplanation"],
                  destination: ExerciseListPage(
                    leading: "assets/muscle.png",
                    type: "Muscle",
                  ),
                  leadingComponent: "assets/muscle.png",
                ),
                ExercisePresentation(
                  destination: ExerciseListPage(
                    type: "Emergency",
                    leading: "assets/emergency.png",
                  ),
                  contentComponent:
                      SettingsManager.mapLanguage["EmergencyExplanation"],
                  titleComponent:
                      SettingsManager.mapLanguage["ExerciseEmergency"],
                  leadingComponent: "assets/emergency.png",
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choiceExerciseButton(text: "Math", index: 0),
                    choiceExerciseButton(text: "Physical", index: 1),
                    choiceExerciseButton(text: "Emergency", index: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarFooter(selectedBottomIndexOffLine: null, selectedBottomIndexOnline: null,),
    );
  }
}
