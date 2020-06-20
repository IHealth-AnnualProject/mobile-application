import 'package:flutter/cupertino.dart';

class Exercise {
  String name;
  String type;
  String description;
  String videoPath;
  Map<String, dynamic> inputPipe;
  Map<String, dynamic> outputPipe;
  String question;
  List<dynamic> answers;
  String result;

  Exercise.pipeExercise(
      {this.name, this.type, this.inputPipe, this.outputPipe});

  Exercise.mathExercise(
      {this.name, this.type, this.question, this.answers, this.result});

  Exercise.emergencyExercise(
      {@required this.name, this.description, @required this.videoPath, @required this.type});

  factory Exercise.fromJson(Map<String, dynamic> json, String type) {
    Exercise exercise;
    if(type == 'Math')
    switch (json['Type']) {
      case 'Logic':
        exercise = Exercise.pipeExercise(
          name: json['Name'],
          type: json['Type'],
          inputPipe: json['InputPipe'],
          outputPipe: json['ResultPipe'],
        );
        break;
      case 'Math':
        exercise = Exercise.mathExercise(
            name: json['Name'],
            type: json['Type'],
            answers: json['Answers'],
            question: json['Question'],
            result: json['Result']);
        break;
    }
    if(type == "Emergency"){
      exercise = Exercise.emergencyExercise(
        name: json['Name'],
        description: json['Description'],
        videoPath: json['videoPath'],
        type: "Training"
      );
    }
    return exercise;
  }

  Exercise.defaultConstructor();
}
