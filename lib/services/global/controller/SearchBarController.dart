import 'dart:convert';

import 'package:betsbi/manager/GeolocationManager.dart';
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/account/controller/SkinController.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/global/model/searchItem.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/tools/AvatarSkinWidget.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import '../../exercise/controller/ExerciseController.dart';

class SearchBarController {
  static String searchCategory = SettingsManager.mapLanguage["User"];
  static List<String> searchChoicesCategory = [
    SettingsManager.mapLanguage["User"],
    SettingsManager.mapLanguage["Psy"],
    SettingsManager.mapLanguage["Exercise"]
  ];

  static Future<List<Exercise>> getAllExercise(
      {@required BuildContext context}) async {
    String jsonWithOutputList;
    jsonWithOutputList = await ExerciseController.getJsonAccodingToExerciseType(
        context: context, type: 'math');
    return ExerciseController.convertJsonToExerciseList(
        jsonToDecode: jsonWithOutputList, type: 'Math');
  }

  static Future<List<SearchItem>> getAllPropsAccordingToCategoryChosen(
      {@required BuildContext context}) async {
    List<SearchItem> items = new List<SearchItem>();
    if (searchCategory == SettingsManager.mapLanguage["User"])
      await getAllUserThenAddItToListOfSearchItem(context, items);
    else if (searchCategory == SettingsManager.mapLanguage["Exercise"])
      await getAllExerciseThenAddItToListOfSearchItem(context, items);
    else if (searchCategory == SettingsManager.mapLanguage["Psy"])
      await getAllPsyThenAddItToListOfSearchItem(context, items);
    return items;
  }

  static Future getAllExerciseThenAddItToListOfSearchItem(
      BuildContext context, List<SearchItem> items) async {
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

  static Future getAllUserThenAddItToListOfSearchItem(
      BuildContext context, List<SearchItem> items) async {
    await getAllUserProfile(context: context).then(
      (users) => users.forEach(
        (user) {
          Widget avatar =
              getUserAvatarAccordingToHisIdForSearch(
                  user: user, context: context);
          items.add(
            SearchItem.userItem(
              trailing: avatar,
              title: user.username,
              user: user,
              subtitle: SettingsManager.mapLanguage["User"],
            ),
          );
        },
      ),
    );
  }

  static Future getAllPsyThenAddItToListOfSearchItem(
      BuildContext context, List<SearchItem> items) async {
    bool isGeolocationOk = await GeolocationManager.areAllPermissionGranted();
    if (!isGeolocationOk) {
      await getAllPsyProfile(context: context).then(
        (users) => users.forEach(
          (user) {
            Widget avatar =
                getUserAvatarAccordingToHisIdForSearch(
                    user: user, context: context);
            items.add(
              SearchItem.userItem(
                trailing: avatar,
                title: user.username,
                user: user,
                subtitle: SettingsManager.mapLanguage["Psy"],
              ),
            );
          },
        ),
      );
    } else {
      List<User> users = await getAllPsyProfile(context: context);
      List<User> sortedList = await sortUserListOnGeolocation(users);
      sortedList.forEach(
        (user) {
          Widget avatar =
              getUserAvatarAccordingToHisIdForSearch(
                  user: user, context: context);
          items.add(
            SearchItem.userItem(
              trailing: avatar,
              title: user.username,
              user: user,
              subtitle: SettingsManager.mapLanguage["Psy"],
            ),
          );
        },
      );
    }
  }

  static Future<List<User>> sortUserListOnGeolocation(List<User> users) async {
    users.forEach((element) {
      if (element.geolocation == null) element.geolocation = "";
    });

    List<User> userWithGeolocation = List<User>();

    userWithGeolocation.addAll(users);
    userWithGeolocation.removeWhere((user) => user.geolocation.isEmpty);
    users.removeWhere((current) => current.geolocation.isNotEmpty);
    Location location = Location();
    LocationData currentLocation;
    currentLocation = await location.getLocation();
    if (userWithGeolocation.length > 1)
      userWithGeolocation.sort((a, b) {
        LatLng psyALatLng = new LatLng(
            double.parse(a.geolocation.split("||")[1].split(",")[0]),
            double.parse(a.geolocation.split("||")[1].split(",")[1]));
        LatLng psyBLatLng = new LatLng(
            double.parse(b.geolocation.split("||")[1].split(",")[0]),
            double.parse(b.geolocation.split("||")[1].split(",")[1]));
        int distanceUserFromA =
            GeolocationManager.getDistanceInMeterBetweenHereAndAnotherPlace(
                currentLocation, psyALatLng);
        int distanceUserFromB =
            GeolocationManager.getDistanceInMeterBetweenHereAndAnotherPlace(
                currentLocation, psyBLatLng);
        return distanceUserFromA.compareTo(distanceUserFromB);
      });
    List<User> sortedListWithNearestUserInFirst = new List<User>();
    sortedListWithNearestUserInFirst.addAll(userWithGeolocation);
    sortedListWithNearestUserInFirst.addAll(users);
    return sortedListWithNearestUserInFirst;
  }

  static Future<List<SearchItem>> getAllMusic(
      {@required BuildContext context}) async {
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

  static Widget getUserAvatarAccordingToHisIdForSearch(
      {@required User user, @required BuildContext context}) {
    int defaultFaceIndex = SkinController.faces.lastIndexWhere(
            (face) => face.level.toString() + face.code == user.skin.split("_")[0]);
    int defaultSkinColorIndex = SkinController.skinColors.lastIndexWhere(
            (color) =>
        color.level.toString() + color.code == user.skin.split("_")[1]);
    int defaultAccessoryIndex = SkinController.accessories.lastIndexWhere(
            (accessory) =>
        accessory.level.toString() + accessory.code ==
            user.skin.split("_")[2]);

    return AvatarSkinWidget.searchConstructor(
      faceImage: SkinController.faces[defaultFaceIndex].image,
      accessoryImage: SkinController.accessories[defaultAccessoryIndex].image,
      skinColor: SkinController.skinColors[defaultSkinColorIndex].colorTable,
    );
  }

  static Future<List<User>> getAllUser(
      {@required BuildContext context,
      @required Function listToReturn,
      @required String path}) async {
    List<User> users = new List<User>();
    HttpManager httpManager = new HttpManager(path: path, context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    users = responseManager.checkResponseRetrieveInformationWithAFunction(toReturn: () => listToReturn(httpManager),elementToReturnIfFalse:  new List<User>());
    return users;
  }

  static Future<List<User>> getAllUserProfile(
      {@required BuildContext context}) async {
    List<User> users = new List<User>();
    users = await getAllUser(
        context: context, listToReturn: fromJsonToUser, path: "userProfile");
    removeCurrentUserFromList(users);
    return users;
  }

  static Future<List<User>> getAllPsyProfile(
      {@required BuildContext context}) async {
    List<User> psychologists = new List<User>();
    psychologists = await getAllUser(
        context: context, listToReturn: fromJsonToPsy, path: "psychologist");
    removeCurrentUserFromList(psychologists);
    return psychologists;
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
    if (searchCategory == SettingsManager.mapLanguage["User"]) {
      redirection =
          AccountPage(isPsy: item.user.isPsy, userId: item.user.profileId);
    } else if (searchCategory == SettingsManager.mapLanguage["Psy"]) {
      redirection =
          AccountPage(isPsy: item.user.isPsy, userId: item.user.profileId);
    } else if (searchCategory == SettingsManager.mapLanguage["Exercise"]) {
      redirection = ExerciseController.getRedirectionAccordingToExerciseType(
          exercise: item.exercise);
    }
    return redirection;
  }

  static Icon getCurrentIconSearchBarCategory() {
    Icon icon;
    if (searchCategory == SettingsManager.mapLanguage["User"]) {
      icon = Icon(CommunityMaterialIcons.account);
    } else if (searchCategory == SettingsManager.mapLanguage["Psy"]) {
      icon = Icon(CommunityMaterialIcons.spa);
    } else if (searchCategory == SettingsManager.mapLanguage["Exercise"]) {
      icon = Icon(CommunityMaterialIcons.note);
    }
    return icon;
  }
}
