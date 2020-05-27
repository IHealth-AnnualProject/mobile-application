import 'package:betsbi/controller/ExerciseController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LogicExerciseState extends State<ExerciseView> {
  List<Widget> listCaseExercise =
      new List<Widget>.generate(36, (i) => Container());
  bool isCongratsHidden = false;

  @override
  void initState() {
    super.initState();
    ExerciseController.createListWidgetOverMapString(exercise: this.widget.exercise,logicExerciseState: this,listCasePipeGame: listCaseExercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RotatedBox(
              quarterTurns: 0,
              child: Container(
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6),
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
