class Exercise {
  String name;
  String type;
  Map<String, dynamic> inputPipe;
  Map<String, dynamic> outputPipe;

  Exercise.tubeExercise(
      {this.name, this.type, this.inputPipe, this.outputPipe});

  factory Exercise.fromJsonToTube(Map<String, dynamic> json) {
    return Exercise.tubeExercise(
      name: json['Name'],
      type: json['Type'],
      inputPipe: json['InputPipe'],
      outputPipe: json['ResultPipe'],
    );
  }

  Exercise.defaultConstructor();
}
