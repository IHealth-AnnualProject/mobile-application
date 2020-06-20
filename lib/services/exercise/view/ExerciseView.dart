import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/exercise/state/LogicExerciseState.dart';
import 'package:betsbi/services/exercise/state/MathExerciseState.dart';
import 'package:betsbi/services/exercise/state/VideoExerciseState.dart';
import 'package:flutter/cupertino.dart';

class ExerciseView extends StatefulWidget {
  final Exercise exercise;
  final bool isOffline;

  ExerciseView({this.exercise, this.isOffline = false});

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
