import 'dart:convert';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/model/emergencyExercise.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/exercise/model/mathExercise.dart';
import 'package:betsbi/services/exercise/model/pipeGame.dart';
import 'package:betsbi/services/exercise/model/similarCard.dart';
import 'package:betsbi/services/exercise/state/PipeExerciseState.dart';
import 'package:betsbi/services/exercise/view/MathExerciseView.dart';
import 'package:betsbi/services/exercise/view/PipeExerciseView.dart';
import 'package:betsbi/services/exercise/view/SimilarCardExerciseView.dart';
import 'package:betsbi/services/exercise/view/VideoExerciseView.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/PipeElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExerciseController {
  static Future<String> getJsonAccordingToExerciseType(
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

  static Widget getRedirectionAccordingToExerciseType(
      {@required Exercise exercise, bool isOffLine = false}) {
    Widget destination;
    switch (exercise.type) {
      case "Math":
        destination = MathExercisePage(
          exercise: exercise,
          isOffline: isOffLine,
        );
        break;
      case "Pipe":
        destination = PipeExercisePage(
          exercise: exercise,
          isOffline: isOffLine,
        );
        break;
      case "Emergency":
        destination = VideoExercisePage(
          exercise: exercise,
          isOffline: isOffLine,
        );
        break;
      case "SimilarCard":
        destination = SimilarCardPage(
          exercise: exercise,
          isOffline: isOffLine,
        );
        break;
    }
    return destination;
  }

  static Future<List<Widget>> getAllJsonAndRecoverListOfExercise(
      {@required BuildContext context}) async {
    String mathExercise =
        await getJsonAccordingToExerciseType(type: "Math", context: context);
    String emergencyExercise = await getJsonAccordingToExerciseType(
        type: "Emergency", context: context);
    List<Widget> listExercises = new List<Widget>();
    listExercises = decodeJsonAndStoreItInsideExerciseList(
        jsonToDecode: mathExercise,
        leading: "assets/math.png",
        context: context,
        isOffLine: true,
        type: 'Math');
    listExercises.addAll(decodeJsonAndStoreItInsideExerciseList(
        jsonToDecode: emergencyExercise,
        leading: "assets/emergency.png",
        context: context,
        isOffLine: true,
        type: 'Emergency'));

    return listExercises;
  }

  static void createListWidgetOverMapString(
      {@required PipeGame pipeGame,
      @required List<Widget> listCasePipeGame,
      @required PipeExerciseState logicExerciseState}) {
    pipeGame.inputPipe.forEach((key, value) {
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

  static Image defaultImage({@required String image}) {
    return Image.asset('assets/exercise/pipe/$image.png');
  }

  static ListTile exerciseWidget(
      {@required String leading,
        @required Exercise exercise,
        @required BuildContext context,
        @required bool isOffLine}) {
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
              builder: (context) => getRedirectionAccordingToExerciseType(
                  exercise: exercise, isOffLine: isOffLine)),
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
    List<Exercise> exercises =
        convertJsonToExerciseList(jsonToDecode: jsonToDecode, type: type);
    if (exercises.isEmpty) return new List<Widget>();
    return fromExerciseToWidget(
        listInputExercise: exercises,
        leading: leading,
        context: context,
        isOffLine: isOffLine);
  }

  static List<Exercise> convertJsonToExerciseList(
      {@required String jsonToDecode, @required String type}) {
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Exercise> exercises = new List<Exercise>();
    if (listFromJson.isEmpty) return exercises;
    exercises.addAll(
      listFromJson.map(
        (model) {
          Exercise exercise;
          if (type == "Emergency") return EmergencyExercise.fromJson(model);
          switch (model["Type"].toString()) {
            case "Math":
              exercise = MathExercise.fromJson(model);
              break;
            case "Pipe":
              exercise = PipeGame.fromJson(model);
              break;
            case "SimilarCard":
              exercise = SimilarCard.fromJson(model);
              break;
          }
          return exercise;
        },
      ),
    );
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

  static showCongratsDialog({@required BuildContext context, String content = ""}) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: DefaultTextTitle(
        title: SettingsManager.mapLanguage["Congratulations"] + "\n" + content,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset("assets/congrats.gif"),
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).whenComplete(() => Navigator.of(context).pop());
  }
}
