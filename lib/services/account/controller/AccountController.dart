import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/account/model/tabContent.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/services/account/view/AccountInformationView.dart';
import 'package:betsbi/services/account/view/AccountTraceView.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountController {
  static Future<UserProfile> getCurrentUserInformation(
      String userID, BuildContext context) async {
    HttpManager httpManager =
        new HttpManager(path: 'userProfile/$userID/user', context: context);
    await httpManager.get();
    UserProfile userProfile = UserProfile.defaultConstructor();
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
      String skin,
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
      String skin,
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
