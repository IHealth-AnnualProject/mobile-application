import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProfile extends User {
  UserProfile.normalConstructor(
      {String birthdate,
      String description,
      String username,
      String userProfileId,
      bool isPsy = false,
      int level,
      String email})
      : super(userProfileId, username, description, birthdate, isPsy, level, email);

  UserProfile.defaultConstructor(
      {String birthdate = "",
      String description = "",
      String username = "",
      String userProfileId = "",
      bool isPsy = false,
      int level = 0,
      String email = ""})
      : super(userProfileId, username, description, birthdate, isPsy, level, email);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
        birthdate: json['birthdate'],
        description: json['description'],
        username: json['user']['username'],
        userProfileId: json['user']['id'],
        level: _determineLevelWithXp(json['user']['xp']),
        email: json['email']
        );
  }

  static int _determineLevelWithXp(int xp)
  {
    return (xp / 100).floor() + 1;
  }

  Future<void> getUserProfile({String userID, BuildContext context}) async {
    await AccountController.getCurrentUserInformation(userID, context)
        .then((userProfileResult) {
      this.birthdate = userProfileResult.birthdate;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.profileId = userProfileResult.profileId;
      this.level = userProfileResult.level;
      this.email = userProfileResult.email;
    });
  }

  Future<void> updateProfile(
      {String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    await AccountController.updateCurrentUserInformation(
            birthdate: birthdate,
            geolocation: "",
            description: description,
            profileId: profileId,
            isPsy: isPsy,
            context: context);
  }
}
