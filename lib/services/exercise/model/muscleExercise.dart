import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';

class MuscleExercise extends Exercise {
  String description;
  String videoPath;

  MuscleExercise(
      {@required String name, this.description, @required this.videoPath, @required String type})
      : super(name, type);

  factory MuscleExercise.fromJson(Map<String, dynamic> json) {
    return MuscleExercise(
        name: json['Name'],
        description: json['Description'],
        videoPath: json['videoPath'],
        type: "Muscle");
  }
}