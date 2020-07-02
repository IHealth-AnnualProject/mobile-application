import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';

class PipeGame extends Exercise {
  Map<String, dynamic> inputPipe;
  Map<String, dynamic> outputPipe;

  PipeGame({@required String name, @required String type, @required this.inputPipe, @required this.outputPipe}) : super(name, type);

  factory PipeGame.fromJson(Map<String, dynamic> json) {
    return PipeGame(
      name: json['Name'],
      type: json['Type'],
      inputPipe: json['InputPipe'],
      outputPipe: json['ResultPipe'],
    );
  }
}
