import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MathExerciseState extends State<ExerciseView> {
  List<Widget> questionList;
  bool isCongratsHidden = false;

  @override
  void initState() {
    convertAnswersToListWidget();
    HistoricalManager.historical.add(this.widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppSearchBar.appSearchBarNormal(
        title: SettingsManager.mapLanguage["SearchContainer"] != null
        ? SettingsManager.mapLanguage["SearchContainer"]
            : "",
        ),
        body:  Column(
          children: <Widget>[
            Text(
              SettingsManager.mapLanguage["MathExerciseExplanation"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.widget.exercise.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(0, 157, 153, 1), fontSize: 30),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              height: 200,
              child:  ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: questionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Wrap(
                    children: <Widget>[
                      questionList[index],
                      SizedBox(width: 10,)
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
      bottomNavigationBar: BottomNavigationBarFooter(null),
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
