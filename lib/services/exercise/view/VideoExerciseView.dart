import 'package:betsbi/services/exercise/model/emergencyExercise.dart';
import 'package:betsbi/services/exercise/state/VideoExerciseState.dart';
import 'package:flutter/cupertino.dart';

class VideoExercisePage extends StatefulWidget{

  final EmergencyExercise exercise;
  final bool isOffline;

  VideoExercisePage({this.exercise, this.isOffline = false});

  @override
  State<VideoExercisePage> createState() => VideoExerciseState();

}