import 'dart:convert';

import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/searchItem.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ExerciseController.dart';

class SearchBarController {
  static String searchCategory = "user";
  static List<String> searchChoicesCategory = ["user", "exercise"];

  static Future<List<Exercise>> getAllExercise({BuildContext context}) async {
    String jsonWithOutputList;
    jsonWithOutputList = await ExerciseController.getJsonAccodingToExerciseType(
        context: context, type: 'math');
    return ExerciseController.convertJsonToExerciseList(
        jsonToDecode: jsonWithOutputList, type: 'Math');
  }

  static Future<List<SearchItem>> getAllPropsAccordingToCategoryChosen(
      {BuildContext context}) async {
    List<SearchItem> items = new List<SearchItem>();
    if (searchCategory.toString() == 'user') {
      await getAllProfile(context).then(
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

  static Future<List<SearchItem>> getAllMusic({BuildContext context}) async {
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

  static Future<List<User>> getAllProfile(BuildContext context) async {
    var users = new List<User>();
    HttpManager httpManager = new HttpManager(path: "userProfile", context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      elementToReturn: new List<User>(),
      functionListToReturn: () => fromJsonToUser(httpManager),
      context: context,
    );
    users = responseManager.checkResponseAndRetrieveListOfInformation();
    // remove psy from list if you're already a psy
    httpManager.setPath(newPath: 'psychologist');
    await httpManager.get();
    responseManager = new ResponseManager(
      response: httpManager.response,
      elementToReturn: new List<User>(),
      functionListToReturn: () => fromJsonToPsy(httpManager),
      context: context,
    );
    users.addAll(responseManager.checkResponseAndRetrieveListOfInformation());
    users.removeWhere((user) =>
        user.profileId == SettingsManager.applicationProperties.getCurrentId());
    return users;
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
      redirection = ExerciseView(
        exercise: item.exercise,
      );
    }
    return redirection;
  }
}
