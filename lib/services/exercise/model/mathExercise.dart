import 'package:betsbi/services/exercise/model/exercise.dart';

class MathExercise extends Exercise {
  String question;
  List<dynamic> answers;
  String result;

  MathExercise(
      {String name, String type, this.question, this.answers, this.result})
      : super(name, type);

  factory MathExercise.fromJson(Map<String, dynamic> json) {
    return MathExercise(
        name: json['Name'],
        type: json['Type'],
        answers: json['Answers'],
        question: json['Question'],
        result: json['Result']);
  }
}
