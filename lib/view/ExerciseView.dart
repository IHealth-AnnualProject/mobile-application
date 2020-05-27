import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/state/LogicExerciseState.dart';
import 'package:betsbi/state/MathExerciseState.dart';
import 'package:betsbi/state/VideoExerciseState.dart';
import 'package:flutter/cupertino.dart';

class ExerciseView extends StatefulWidget {
  final Exercise exercise;

  ExerciseView(this.exercise);

  @override
  State<ExerciseView> createState() {
    State<ExerciseView> returnStatement;
    switch (this.exercise.type) {
      case 'Logic':
        returnStatement = LogicExerciseState();
        break;
      case 'Math':
        returnStatement = MathExerciseState();
        break;
      case 'Training':
        returnStatement = VideoExerciseState();
        break;
    }
    return returnStatement;
  }
}
