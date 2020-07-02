import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';

class EmergencyExercise extends Exercise {
  String description;
  String videoPath;

  EmergencyExercise(
      {@required String name, this.description, @required this.videoPath, @required String type})
      : super(name, type);

  factory EmergencyExercise.fromJson(Map<String, dynamic> json) {
    return EmergencyExercise(
        name: json['Name'],
        description: json['Description'],
        videoPath: json['videoPath'],
        type: "Emergency");
  }
}
