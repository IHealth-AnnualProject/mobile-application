import 'package:betsbi/services/exercise/model/emergencyExercise.dart';
import 'package:betsbi/services/exercise/state/EmergencyExerciseState.dart';
import 'package:flutter/cupertino.dart';

class EmergencyExercisePage extends StatefulWidget{

  final EmergencyExercise exercise;
  final bool isOffline;

  EmergencyExercisePage({this.exercise, this.isOffline = false});

  @override
  State<EmergencyExercisePage> createState() => EmergencyExerciseState();

}