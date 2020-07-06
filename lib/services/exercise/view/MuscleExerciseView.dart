import 'package:betsbi/services/exercise/model/muscleExercise.dart';
import 'package:betsbi/services/exercise/state/MuscleExerciseState.dart';
import 'package:flutter/cupertino.dart';

class MuscleExercisePage extends StatefulWidget{

  final MuscleExercise exercise;

  MuscleExercisePage({this.exercise});

  @override
  State<StatefulWidget> createState() => MuscleExerciseState();

}