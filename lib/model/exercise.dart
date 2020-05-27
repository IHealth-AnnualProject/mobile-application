class Exercise {
  String name;
  String type;
  Map<String, dynamic> inputPipe;
  Map<String, dynamic> outputPipe;
  String question;
  List<dynamic> answers;
  String result;

  Exercise.pipeExercise(
      {this.name, this.type, this.inputPipe, this.outputPipe});

  Exercise.mathExercise(
      {this.name, this.type, this.question, this.answers, this.result});

  factory Exercise.fromJsonToList(Map<String, dynamic> json) {
    Exercise exercise;
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
    return exercise;
  }

  Exercise.defaultConstructor();
}
