import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MathExerciseState extends State<ExerciseView> {
  List<Widget> questionList;
  bool isCongratsHidden = false;

  @override
  void initState() {
    convertAnswersToListWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              this.widget.exercise.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
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
