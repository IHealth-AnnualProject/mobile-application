import 'package:betsbi/services/exercise/model/pipeGame.dart';
import 'package:betsbi/services/exercise/state/PipeExerciseState.dart';
import 'package:flutter/cupertino.dart';

class PipeExercisePage extends StatefulWidget{
  final PipeGame exercise;
  final bool isOffline;

  PipeExercisePage({this.exercise, this.isOffline = false});

  @override
  State<PipeExercisePage> createState() => PipeExerciseState();

}