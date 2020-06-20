import 'dart:convert';

import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/exercise/state/LogicExerciseState.dart';
import 'package:betsbi/services/exercise/view/ExerciseView.dart';
import 'package:betsbi/tools/PipeElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExerciseController {
  static Future<String> getJsonAccodingToExerciseType(
      {@required String type, @required BuildContext context}) {
    switch (type) {
      case "Math":
        return DefaultAssetBundle.of(context)
            .loadString('assets/exercise/mathAndLogicExercise.json');
        break;
      case "Emergency":
        return DefaultAssetBundle.of(context)
            .loadString('assets/exercise/emergencyExercise.json');
        break;
      default:
        return DefaultAssetBundle.of(context)
            .loadString('assets/exercise/mathAndLogicExercise.json');
        break;
    }
  }

  static Future<List<Widget>> getAllJsonAndRecoverListOfExercise(
      {@required BuildContext context}) async {
    String mathExercise = await getJsonAccodingToExerciseType(type: "Math", context: context);
    String emergencyExercise = await getJsonAccodingToExerciseType(
        type: "Emergency", context: context);
    List<Widget> listExercises = new List<Widget>();
    listExercises = decodeJsonAndStoreItInsideExerciseList(jsonToDecode: mathExercise, leading: "assets/math.png", context: context, isOffLine: true, type: 'Math');
    listExercises.addAll(decodeJsonAndStoreItInsideExerciseList(jsonToDecode: emergencyExercise, leading: "assets/emergency.png", context: context, isOffLine: true, type: 'Emergency'));
    return listExercises;
  }

  static void createListWidgetOverMapString(
      {@required Exercise exercise,
      @required List<Widget> listCasePipeGame,
      @required LogicExerciseState logicExerciseState}) {
    exercise.inputPipe.forEach((key, value) {
      if (value == 'end' || value == 'start') {
        listCasePipeGame[int.parse(key)] = defaultImage(image: value);
      } else
        listCasePipeGame[int.parse(key)] = PipeElement(
          idMap: key,
          name: value,
          logicExerciseState: logicExerciseState,
        );
    });
  }

  static Image defaultImage({String image}) {
    return Image.asset('assets/exercise/pipe/$image.png');
  }

  static ListTile exerciseWidget(
      {@required String leading,
      Exercise exercise,
      BuildContext context,
      bool isOffLine}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(leading),
      ),
      title: Text(exercise.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExercisePage(
              exercise: exercise,
              isOffline: isOffLine,
            ),
          ),
        );
      },
    );
  }

  static List<Widget> decodeJsonAndStoreItInsideExerciseList(
      {@required String jsonToDecode,
      @required String leading,
      @required BuildContext context,
      @required bool isOffLine,
      @required String type}) {
    List<Exercise> exercises = convertJsonToExerciseList(jsonToDecode: jsonToDecode, type: type);
    if (exercises.isEmpty) return new List<Widget>();
    return fromExerciseToWidget(
        listInputExercise: exercises,
        leading: leading,
        context: context,
        isOffLine: isOffLine);
  }

  static List<Exercise> convertJsonToExerciseList({@required String jsonToDecode, @required String type}){
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Exercise> exercises = new List<Exercise>();
    if (listFromJson.isEmpty) return exercises;
    exercises.addAll(
        listFromJson.map((model) => Exercise.fromJson(model, type)).toList());
    return exercises;
  }

  static List<Widget> fromExerciseToWidget(
      {@required List<Exercise> listInputExercise,
      @required String leading,
      @required BuildContext context,
      @required bool isOffLine}) {
    List<Widget> listExerciseWidget = new List<Widget>();
    listInputExercise.forEach(
      (exercise) => listExerciseWidget.add(
        exerciseWidget(
            leading: leading,
            exercise: exercise,
            context: context,
            isOffLine: isOffLine),
      ),
    );
    return listExerciseWidget;
  }
}
