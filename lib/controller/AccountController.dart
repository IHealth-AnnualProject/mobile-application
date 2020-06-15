import 'dart:convert';

import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/tabContent.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/widget/AccountInformation.dart';
import 'package:betsbi/widget/AccountTrace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountController {
  static Future<UserProfile> getCurrentUserInformation(
      String userID, BuildContext context) async {
    HttpManager httpManager =
        new HttpManager(path: 'userProfile/$userID/user', context: context);
    await httpManager.get();
    UserProfile userProfile = UserProfile.defaultConstructor();
    print(httpManager.response.body);
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        elementToReturn: userProfile,
        functionFromJsonToReturn: () =>
            UserProfile.fromJson(json.decode(httpManager.response.body)));
    return responseManager.checkResponseAndRetrieveInformationFromJson();
  }

  static Future<Psychologist> getCurrentPsyInformation(
      String psyId, BuildContext context) async {
    HttpManager httpManager =
        new HttpManager(path: 'psychologist/$psyId/user', context: context);
    await httpManager.get();
    Psychologist psychologist = new Psychologist.defaultConstructor();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        elementToReturn: psychologist,
        functionFromJsonToReturn: () =>
            Psychologist.fromJson(json.decode(httpManager.response.body)));
    return responseManager.checkResponseAndRetrieveInformationFromJson();
  }

  static Future<void> updateCurrentUserInformation(
      {String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'userProfile',
        context: context,
        map: <String, dynamic>{
          "birthdate": birthdate,
          "description": description
        });
    await httpManager.patch();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
      destination: AccountPage(
        userId: profileId,
        isPsy: isPsy,
      ),
      successMessage: SettingsManager.mapLanguage["UpdateUserInformation"],
    );
    responseManager.checkResponseAndShowIt();
  }

  static Future<void> updateCurrentPsyInformation(
      {String firstname,
      String lastname,
      String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'psychologist',
        context: context,
        map: <String, dynamic>{
          "first_name": firstname,
          "last_name": lastname,
          "birthdate": birthdate,
          "description": description
        });
    await httpManager.patch();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
      destination: AccountPage(
        userId: profileId,
        isPsy: isPsy,
      ),
      successMessage: SettingsManager.mapLanguage["UpdateUserInformation"],
    );
    responseManager.checkResponseAndShowIt();
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
        AccountInformation(
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
        AccountInformation(
          profile: user,
          isReadOnly: true,
          isPsy: user.isPsy,
        ),
        AccountTrace(
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
        AccountInformation(
          profile: user,
          isReadOnly: false,
          isPsy: user.isPsy,
        ),
        AccountTrace(
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
        AccountInformation(
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
