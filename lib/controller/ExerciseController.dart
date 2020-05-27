import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/state/LogicExerciseState.dart';
import 'package:betsbi/widget/PipeElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ExerciseController {
  static Future<String> getJsonAccodingToExerciseType(
      {@required String type, @required BuildContext context}) {
    return DefaultAssetBundle.of(context)
        .loadString('assets/exercise/mathAndLogicExercise.json');
  }

  static void createListWidgetOverMapString(
      {@required Exercise exercise,
      @required List<Widget> listCasePipeGame,
      @required LogicExerciseState logicExerciseState}) {
    exercise.inputPipe.forEach(
      (key, value) => listCasePipeGame[int.parse(key)] = PipeElement(
        idMap: key,
        name: value,
        logicExerciseState: logicExerciseState,
      ),
    );
  }
}
