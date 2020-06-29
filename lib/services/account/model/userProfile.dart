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
      String email,
      String skin})
      : super(userProfileId, username, description, birthdate, isPsy, level,
            email, skin);

  UserProfile.defaultConstructor(
      {String birthdate = "",
      String description = "",
      String username = "",
      String userProfileId = "",
      bool isPsy = false,
      int level = 0,
      String email = "",
      String skin = "1AAAA_1AAAA_1AAAA"})
      : super(userProfileId, username, description, birthdate, isPsy, level,
            email, skin);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
      birthdate: json['birthdate'],
      description: json['description'],
      username: json['user']['username'],
      userProfileId: json['user']['id'],
      level: _determineLevelWithXp(json['user']['xp']),
      email: json['email'],
      skin:
          json['skin'].toString().isEmpty ? "1AAAA_1AAAA_1AAAA" : json['skin'],
    );
  }

  static int _determineLevelWithXp(int xp) {
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
      this.skin = userProfileResult.skin;
    });
  }

  Future<void> updateProfile(
      {String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      String skin,
      BuildContext context}) async {
    await AccountController.updateCurrentUserInformation(
        birthdate: birthdate,
        geolocation: "",
        description: description,
        profileId: profileId,
        isPsy: isPsy,
        skin: skin,
        context: context);
  }
}
