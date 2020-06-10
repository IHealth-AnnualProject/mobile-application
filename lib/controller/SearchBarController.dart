import 'dart:convert';

import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/model/Response.dart';
import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/searchItem.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ExerciseController.dart';

class SearchBarController {
  static String searchCategory = "user";
  static List<String> searchChoicesCategory = ["user", "exercise"];

  static Future<List<Exercise>> getAllExercise({BuildContext context}) async {
    String jsonWithOutputList;
    jsonWithOutputList = await ExerciseController.getJsonAccodingToExerciseType(
        context: context, type: 'math');
    List<Widget> searchList = new List<Widget>();
    return ExerciseController.decodeJsonAndStoreItInsideExerciseList(
        jsonWithOutputList, searchList, "assets/math.png", context, false);
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
    await AmbianceController.getAllSongs().then(
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

  // todo test when api ready
  static Future<List<User>> getAllProfile(BuildContext context) async {
    var users = new List<User>();
    HttpManager httpManager = new HttpManager(path: "userProfile");
    await httpManager.get();
    _checkResponseUserAndUpdateListIFOK(httpManager.response, users, context);
    // remove psy from list if you're already a psy
    httpManager.setPath(newPath: 'psychologist');
    await httpManager.get();
    _checkResponsePSYAndUpdateListIFOK(httpManager.response, users, context);
    return users;
  }

  static void _checkResponseUserAndUpdateListIFOK(
      http.Response response, List<User> users, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      Iterable list = json.decode(response.body);
      users.addAll(list.map((model) => UserProfile.fromJson(model)).toList());
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
  }

  static void _checkResponsePSYAndUpdateListIFOK(
      http.Response response, List<User> users, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      Iterable list = json.decode(response.body);
      list = json.decode(response.body);
      users.addAll(
          list.map((model) => Psychologist.fromJsonForSearch(model)).toList());
      users.removeWhere((user) =>
          user.profileId ==
          SettingsManager.applicationProperties.getCurrentToken());
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
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
