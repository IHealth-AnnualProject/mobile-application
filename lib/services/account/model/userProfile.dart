import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProfile extends User {
  UserProfile.normalConstructor(
      {String birthDate,
      String description,
      String username,
      String userProfileId,
      bool isPsy = false,
      int level,
      String email,
      String skin,String geolocation})
      : super(userProfileId, username, description, birthDate, isPsy, level,
            email, skin, geolocation);

  UserProfile.defaultConstructor(
      {String birthDate = "",
      String description = "",
      String username = "",
      String userProfileId = "",
      bool isPsy = false,
      int level = 0,
      String email = "",
      String skin = "1AAAA_1AAAA_1AAAA", String geolocation =""})
      : super(userProfileId, username, description, birthDate, isPsy, level,
            email, skin,geolocation);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
      birthDate: json['birthdate'],
      description: json['description'],
      username: json['user']['username'],
      userProfileId: json['user']['id'],
      level: _determineLevelWithXp(json['user']['xp']),
      email: json['email'],
      skin:
          json['user']['skin'].toString().isEmpty ? "1AAAA_1AAAA_1AAAA" : json['user']['skin'],
    );
  }

  static int _determineLevelWithXp(int xp) {
    return (xp / 100).floor() + 1;
  }

  Future<void> getUserProfile({@required String userID, @required BuildContext context}) async {
    await AccountController.getCurrentUserInformation(userID : userID, context : context)
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
      {@required String birthDate,
        @required String description,
        @required String profileId,
        @required BuildContext context}) async {
    await AccountController.updateCurrentUserInformation(
        birthDate: birthDate,
        description: description,
        profileId: profileId,
        context: context);
  }
}
