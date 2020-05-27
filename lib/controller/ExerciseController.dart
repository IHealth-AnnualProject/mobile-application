import 'package:flutter/cupertino.dart';

class ExerciseController {


  static Future<String> getJsonAccodingToExerciseType({String type, BuildContext context})
  {
    return DefaultAssetBundle.of(context)
        .loadString('assets/exercise/mathAndLogicExercise.json');
  }

}