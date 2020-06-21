import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/global/model/searchItem.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exercise/controller/ExerciseController.dart';

class SearchBarController {
  static String searchCategory = "user";
  static List<String> searchChoicesCategory = ["user", "exercise"];

  static Future<List<Exercise>> getAllExercise({@required BuildContext context}) async {
    String jsonWithOutputList;
    jsonWithOutputList = await ExerciseController.getJsonAccodingToExerciseType(
        context: context, type: 'math');
    return ExerciseController.convertJsonToExerciseList(
        jsonToDecode: jsonWithOutputList, type: 'Math');
  }

  static Future<List<SearchItem>> getAllPropsAccordingToCategoryChosen(
      {@required BuildContext context}) async {
    List<SearchItem> items = new List<SearchItem>();
    if (searchCategory.toString() == 'user') {
      await getAllProfile(context : context).then(
        (users) => users.forEach(
          (user) => items.add(
            SearchItem.userItem(
                trailing:
                    user.isPsy ? Icon(Icons.spa) : Icon(Icons.account_box),
                title: user.username,
                user: user,
                subtitle: user.isPsy
                    ? SettingsManager.mapLanguage["PsyChoice"]
                    : SettingsManager.mapLanguage["UserChoice"]),
          ),
        ),
      );
    }
    if (searchCategory.toString() == 'exercise') {
      await getAllExercise(context: context).then(
        (exercises) => exercises.forEach(
          (exercise) => items.add(
            SearchItem.exerciseItem(
              subtitle: exercise.type,
              title: exercise.name,
              exercise: exercise,
              trailing: Icon(Icons.note),
            ),
          ),
        ),
      );
    }
    return items;
  }

  static Future<List<SearchItem>> getAllMusic({@required BuildContext context}) async {
    List<SearchItem> items = new List<SearchItem>();
    await AmbianceController.getAllSongs(context: context).then(
      (songs) => songs.forEach(
        (song) {
          items.add(
            SearchItem.songItem(
              subtitle: song.duration,
              title: song.songName,
              trailing: Icon(Icons.play_arrow),
              song: song,
            ),
          );
        },
      ),
    );
    return items;
  }

  static Future<List<User>> getAllUser({@required BuildContext context, @required Function listToReturn, @required String path}) async
  {
    List<User> users = new List<User>();
    HttpManager httpManager =
    new HttpManager(path: path, context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      elementToReturn: new List<User>(),
      functionListToReturn: () => listToReturn(httpManager),
      context: context,
    );
    users = responseManager.checkResponseAndRetrieveListOfInformation();
    return users;
  }

  static Future<List<User>> getAllProfile({@required BuildContext context}) async {
    List<User> users = new List<User>();
    users = await getAllUser(context: context, listToReturn: fromJsonToUser, path: "userProfile");
    users.addAll(await getAllUser(context: context, listToReturn: fromJsonToPsy, path: "psychologist"));
    removeCurrentUserFromList(users);
    return users;
  }

  static removeCurrentUserFromList(List<User> users) {
    users.removeWhere((user) =>
        user.profileId == SettingsManager.applicationProperties.getCurrentId());
  }

  static List<User> fromJsonToUser(HttpManager httpManager) {
    List<User> users = new List<User>();
    Iterable list = json.decode(httpManager.response.body);
    users.addAll(list.map((model) => UserProfile.fromJson(model)).toList());
    return users;
  }

  static List<User> fromJsonToPsy(HttpManager httpManager) {
    List<User> users = new List<User>();
    Iterable list = json.decode(httpManager.response.body);
    users.addAll(
        list.map((model) => Psychologist.fromJsonForSearch(model)).toList());
    return users;
  }

  static Widget redirectAfterPushing(SearchItem item) {
    Widget redirection;
    if (searchCategory == 'user') {
      redirection =
          AccountPage(isPsy: item.user.isPsy, userId: item.user.profileId);
    }
    if (searchCategory == 'exercise') {
      redirection = ExerciseController.getRedirectionAccordingToExerciseType(exercise: item.exercise);
    }
    return redirection;
  }
}
