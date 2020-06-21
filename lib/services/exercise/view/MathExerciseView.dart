import 'package:betsbi/services/exercise/model/mathExercise.dart';
import 'package:betsbi/services/exercise/state/MathExerciseState.dart';
import 'package:flutter/cupertino.dart';

class MathExercisePage  extends StatefulWidget{
  final MathExercise exercise;
  final bool isOffline;

  MathExercisePage({this.exercise, this.isOffline = false});

  @override
  State<MathExercisePage> createState() => MathExerciseState();
}