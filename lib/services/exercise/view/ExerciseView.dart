import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/exercise/state/LogicExerciseState.dart';
import 'package:betsbi/services/exercise/state/MathExerciseState.dart';
import 'package:betsbi/services/exercise/state/VideoExerciseState.dart';
import 'package:flutter/cupertino.dart';

class ExercisePage extends StatefulWidget {
  final Exercise exercise;
  final bool isOffline;

  ExercisePage({this.exercise, this.isOffline = false});

  @override
  State<ExercisePage> createState() {
    State<ExercisePage> returnStatement;
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
