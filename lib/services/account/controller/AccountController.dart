import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/model/UserSkin.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/account/model/tabContent.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/services/account/view/AccountInformationView.dart';
import 'package:betsbi/services/account/view/AccountTraceView.dart';
import 'package:betsbi/tools/AvatarSkinWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SkinController.dart';

class AccountController {
  static Future<UserProfile> getCurrentUserInformation({
      @required String userID, @required BuildContext context}) async {
    HttpManager httpManager = HttpManager(path: 'userProfile/$userID/user', context: context);
    await httpManager.get();
    UserProfile userProfile = UserProfile.defaultConstructor();
    ResponseManager responseManager = ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => UserProfile.fromJson(
              json.decode(httpManager.response.body),
            ),
        elementToReturnIfFalse: userProfile);
  }

  static Future<Psychologist> getCurrentPsyInformation({
    @required  String psyId, @required BuildContext context}) async {
    HttpManager httpManager = HttpManager(path: 'psychologist/$psyId/user', context: context);
    await httpManager.get();
    Psychologist psychologist =  Psychologist.defaultConstructor();
    ResponseManager responseManager =  ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => Psychologist.fromJson(
              json.decode(httpManager.response.body),
            ),
        elementToReturnIfFalse: psychologist);
  }

  static Widget getUserAvatarAccordingToHisIdForAccountAsWidget(
      {@required String userSkin}) {
    int defaultFaceIndex = SkinController.faces.lastIndexWhere(
        (face) => face.level.toString() + face.code == userSkin.split("_")[0]);
    int defaultSkinColorIndex = SkinController.skinColors.lastIndexWhere(
        (color) =>
            color.level.toString() + color.code == userSkin.split("_")[1]);
    int defaultAccessoryIndex = SkinController.accessories.lastIndexWhere(
        (accessory) =>
            accessory.level.toString() + accessory.code ==
            userSkin.split("_")[2]);

    return AvatarSkinWidget.accountConstructor(
      faceImage: SkinController.faces[defaultFaceIndex].image,
      accessoryImage: SkinController.accessories[defaultAccessoryIndex].image,
      skinColor: SkinController.skinColors[defaultSkinColorIndex].colorTable,
    );
  }

  static Widget getUserAvatarAccordingToHisIdForAccountAsSearchWidget(
      {@required String userSkin}) {
    int defaultFaceIndex = SkinController.faces.lastIndexWhere(
        (face) => face.level.toString() + face.code == userSkin.split("_")[0]);
    int defaultSkinColorIndex = SkinController.skinColors.lastIndexWhere(
        (color) =>
            color.level.toString() + color.code == userSkin.split("_")[1]);
    int defaultAccessoryIndex = SkinController.accessories.lastIndexWhere(
        (accessory) =>
            accessory.level.toString() + accessory.code ==
            userSkin.split("_")[2]);

    return AvatarSkinWidget.searchConstructor(
      faceImage: SkinController.faces[defaultFaceIndex].image,
      accessoryImage: SkinController.accessories[defaultAccessoryIndex].image,
      skinColor: SkinController.skinColors[defaultSkinColorIndex].colorTable,
    );
  }

  static UserSkin getUserAvatarAccordingToHisIdForAccountAsObject(
      {@required String userSkin}) {
    int defaultFaceIndex = SkinController.faces.lastIndexWhere(
        (face) => face.level.toString() + face.code == userSkin.split("_")[0]);
    int defaultSkinColorIndex = SkinController.skinColors.lastIndexWhere(
        (color) =>
            color.level.toString() + color.code == userSkin.split("_")[1]);
    int defaultAccessoryIndex = SkinController.accessories.lastIndexWhere(
        (accessory) =>
            accessory.level.toString() + accessory.code ==
            userSkin.split("_")[2]);
    return UserSkin(
        accessoryPath: SkinController.accessories[defaultAccessoryIndex].image,
        skinColor: SkinController.skinColors[defaultSkinColorIndex].colorTable,
        facePath: SkinController.faces[defaultFaceIndex].image);
  }

  static Future<void> updateCurrentUserInformation(
      {@required String birthDate,
        @required String description,
        @required String profileId,
        @required BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'userProfile',
        context: context,
        map: <String, dynamic>{
          "birthdate": birthDate,
          "description": description
        });
    await httpManager.patch();
    ResponseManager responseManager =  ResponseManager(
      response: httpManager.response,
      context: context,
    );
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(
        successMessage: SettingsManager.mapLanguage["UpdateUserInformation"]);
  }

  static Future<void> updateCurrentPsyInformation(
      {String firstName,
      String lastName,
      String birthDate,
      String geolocation,
      String description,
      String profileId,
      BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'psychologist',
        context: context,
        map: <String, dynamic>{
          "first_name": firstName,
          "last_name": lastName,
          "birthdate": birthDate,
          "description": description,
          "geolocation": geolocation
        });
    await httpManager.patch();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(
        successMessage: SettingsManager.mapLanguage["UpdateUserInformation"]);
  }

  static TabContent getTabBarAndViewAccordingToUserTypeAndId(
      {@required User user}) {
    if (SettingsManager.applicationProperties.isPsy() == "false" &&
        user.profileId !=
            SettingsManager.applicationProperties.getCurrentId()) {
      return new TabContent(tabText: [
        Tab(
          text: "Information",
        )
      ], tabWidget: [
        AccountInformationPage(
          profile: user,
          isReadOnly: true,
          isPsy: user.isPsy,
        ),
      ]);
    }
    if (SettingsManager.applicationProperties.isPsy() == "true" &&
        user.profileId !=
            SettingsManager.applicationProperties.getCurrentId()) {
      return new TabContent(tabText: [
        Tab(
          text: "Information",
        ),
        Tab(
          text: SettingsManager.mapLanguage["Trace"],
        )
      ], tabWidget: [
        AccountInformationPage(
          profile: user,
          isReadOnly: true,
          isPsy: user.isPsy,
        ),
        AccountTracePage(
          profile: user,
        ),
      ]);
    }
    if (SettingsManager.applicationProperties.isPsy() == "false" &&
        user.profileId ==
            SettingsManager.applicationProperties.getCurrentId()) {
      return new TabContent(tabText: [
        Tab(
          text: "Information",
        ),
        Tab(
          text: SettingsManager.mapLanguage["Trace"],
        )
      ], tabWidget: [
        AccountInformationPage(
          profile: user,
          isReadOnly: false,
          isPsy: user.isPsy,
        ),
        AccountTracePage(
          profile: user,
        ),
      ]);
    }
    if (SettingsManager.applicationProperties.isPsy() == "true" &&
        user.isPsy == true)
      return new TabContent(tabText: [
        Tab(
          text: "Information",
        )
      ], tabWidget: [
        AccountInformationPage(
          profile: user,
          isReadOnly: SettingsManager.applicationProperties.getCurrentId() ==
                  user.profileId
              ? false
              : true,
          isPsy: user.isPsy,
        ),
      ]);

    return null;
  }
}
