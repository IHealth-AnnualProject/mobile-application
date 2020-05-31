import 'dart:convert';

import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/state/LogicExerciseState.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:betsbi/widget/PipeElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      (key, value) {
        if(value == 'end' || value == 'start') {
          listCasePipeGame[int.parse(key)] = defaultImage(image: value);
        }
        else
        listCasePipeGame[int.parse(key)] = PipeElement(
          idMap: key,
          name: value,
          logicExerciseState: logicExerciseState,
        );
      }
    );
  }

  static Image defaultImage({String image}) {
    return Image.asset('assets/exercise/pipe/$image.png');
  }

  static ListTile exercise({@required String leading, Exercise exercise, BuildContext context, bool isOffLine}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(leading),
      ),
      title: Text(exercise.name),
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseView(exercise: exercise,isOffline: isOffLine,),
          ),
              (Route<dynamic> route) => false,
        );
        //_controller.play();
      },
      subtitle: Text(exercise.type),
    );
  }

  static List<Exercise> decodeJsonAndStoreItInsideExerciseList(String jsonToDecode, List<Widget> inputList, String leading, BuildContext context, bool isOffLine) {
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Exercise> exercises = new List<Exercise>();
    exercises.addAll(
        listFromJson.map((model) => Exercise.fromJsonToList(model)).toList());
    exercises.forEach(
          (element) {
        inputList.add(
          exercise(leading: leading, exercise: element, context: context,isOffLine: isOffLine),
        );
      },
    );
    return exercises;
  }
}
