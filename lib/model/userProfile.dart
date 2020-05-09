import 'package:betsbi/controller/AccountController.dart';
import 'package:betsbi/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProfile extends User {
  UserProfile.normalConstructor(
      {String birthdate,
      String description,
      String username,
      String userProfileId,
      bool isPsy = false})
      : super(userProfileId, username, description, birthdate, isPsy);

  UserProfile.defaultConstructor(
      {String birthdate = "",
      String description = "",
      String username = "",
      String userProfileId = "",
      bool isPsy = false})
      : super(userProfileId, username, description, birthdate, isPsy);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
        birthdate: json['birthdate'],
        description: json['description'],
        username: json['user']['username'],
        userProfileId: json['user']['id']);
  }

  Future<void> getUserProfile({String userID, BuildContext context}) async {
    await AccountController.getCurrentUserInformation(userID, context)
        .then((userProfileResult) {
      this.birthdate = userProfileResult.birthdate;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.profileId = userProfileResult.profileId;
    });
  }

  Future<bool> updateProfile(
      {String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    bool isUpdated = false;
    await AccountController.updateCurrentUserInformation(
            birthdate: birthdate,
            geolocation: "",
            description: description,
            profileId: profileId,
            isPsy: isPsy,
            context: context)
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
