import 'package:betsbi/services/exercise/state/PipeExerciseState.dart';
import 'package:flutter/cupertino.dart';

class PipeElement extends StatefulWidget {
  final String name;
  final String idMap;
  final PipeExerciseState logicExerciseState;

  PipeElement({this.name, this.logicExerciseState, this.idMap});

  @override
  State<PipeElement> createState() => PipeElementState();
}

class PipeElementState extends State<PipeElement> {
  int rotation = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.setState(() => rotation = rotation + 5);
        onElementTapChangeInputPipe();
        this.widget.logicExerciseState.checkMapEquality();
      },
      child: RotatedBox(
        quarterTurns: rotation,
        child: Image(
          image: AssetImage("assets/exercise/pipe/" + this.widget.name + ".png"),
        ),
      ),
    );
  }

  void onElementTapChangeInputPipe() {
    String actualValueOfInputPipeMap = this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap];
    switch(actualValueOfInputPipeMap){
      case "pipe-to-left":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "pipe-to-top";
        break;
      case "pipe-to-top":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "pipe-to-bottom";
        break;
      case "pipe-to-bottom":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "pipe-to-right";
        break;
      case "pipe-to-right":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "pipe-to-left";
        break;
      case "straight-horiz":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "straight-verti";
        break;
      case "straight-verti":
        this.widget.logicExerciseState.widget.exercise.inputPipe[this.widget.idMap] = "straight-horiz";
        break;
    }

  }
}
