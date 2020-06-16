import 'package:flutter/cupertino.dart';

class Quest {
  int questId;
  String questTitle;
  String questDifficulty;
  String questDescription;
  int questDone;

  Quest(
      {this.questId,
      @required this.questTitle,
      @required this.questDifficulty,
      @required this.questDescription,
      @required this.questDone});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'questTitle': questTitle,
      'questDifficulty': questDifficulty,
      'questDescription': questDescription,
      'questDone': questDone
    };
    if (questId != null) map['id'] = questId;
    return map;
  }

  @override
  String toString() {
    return 'Quest{id: $questId, title: $questTitle, difficulty: $questDifficulty, description : $questDescription}';
  }

  changeDone(int status) => questDone = status;
}
