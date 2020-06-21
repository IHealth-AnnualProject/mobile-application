import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';

class MathExercise extends Exercise {
  String question;
  List<dynamic> answers;
  String result;
  String explanation;

  MathExercise(
      {String name, String type, this.question, this.answers, this.result, this.explanation})
      : super(name, type);

  factory MathExercise.fromJson(Map<String, dynamic> json) {
    return MathExercise(
        name: json['Name'],
        type: json['Type'],
        answers: json['Answers'],
        question: SettingsManager.mapLanguage.containsKey(json['Question']) ?SettingsManager.mapLanguage[json['Question']] : "" ,
        result: json['Result'],
        explanation: json['Explanation'] != "" ? SettingsManager.mapLanguage[json['Explanation']] : "");
  }
}
