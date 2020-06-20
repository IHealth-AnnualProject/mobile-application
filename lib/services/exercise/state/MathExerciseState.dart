import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/view/ExerciseView.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MathExerciseState extends State<ExercisePage> with WidgetsBindingObserver {
  List<Widget> questionList;
  bool isCongratsHidden = false;

  @override
  void initState() {
    convertAnswersToListWidget();
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !this.widget.isOffline) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(isOffline: this.widget.isOffline,),
      body: Column(
        children: <Widget>[
          Text(
            SettingsManager.mapLanguage["MathExerciseExplanation"],
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.widget.exercise.question,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 30),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: questionList.length,
              itemBuilder: (BuildContext context, int index) {
                return Wrap(
                  children: <Widget>[
                    questionList[index],
                    SizedBox(
                      width: 10,
                    )
                  ],
                );
              },
            ),
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

  void checkAnswerWithResult(String answer) {
    setState(() {
      answer == this.widget.exercise.result
          ? isCongratsHidden = true
          : isCongratsHidden = false;
    });
  }

  void convertAnswersToListWidget() {
    questionList = new List<Widget>();
    this.widget.exercise.answers.forEach((element) {
      questionList.add(
        RaisedButton(
          onPressed: () => checkAnswerWithResult(element.toString()),
          child: Text(element.toString()),
        ),
      );
    });
  }
}
