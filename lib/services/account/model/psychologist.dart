import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:flutter/cupertino.dart';

class Psychologist extends User {
  String firstName;
  String lastName;

  Psychologist.normalConstructor(
      {this.firstName,
      this.lastName,
      String profileId,
      String username,
      String description,
      String birthdate,
      bool isPsy = true,
      int level,String email})
      : super(profileId, username, description, birthdate, isPsy,level, email);

  Psychologist.defaultConstructor(
      {this.firstName = "",
      this.lastName = "",
      String profileId = "",
      String username = "",
      String description = "",
      String birthdate = "",
      bool isPsy = true,
      int level = 0,String email = ""})
      : super(profileId, username, description, birthdate, isPsy, level, email);

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['user']['username'],
        birthdate: json['birthdate'],
        description: json['description'],
        profileId: json['id'],
        level: _determineLevelWithXp(json['user']['xp']),
        email: json['email']
        );
  }

  static int _determineLevelWithXp(int xp)
  {
    return (xp / 100).floor() + 1;
  }

  factory Psychologist.fromJsonForSearch(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
        birthdate: json['birthdate'],
        description: json['description'],
        username: json['user']['username'],
        profileId: json['id']
    );
  }

  Future<void> getUserProfile({String userID, BuildContext context}) async {
    await AccountController.getCurrentPsyInformation(userID, context)
        .then((userProfileResult) {
      this.firstName = userProfileResult.firstName;
      this.lastName = userProfileResult.lastName;
      this.birthdate = userProfileResult.birthdate;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.profileId = userProfileResult.profileId;
      this.level = userProfileResult.level;
      this.email = userProfileResult.email;
    });
  }

  Future<void> updateProfile(
      {String firstname,
      String lastname,
      String birthdate,
      String geolocation,
      String description,
        String profileId,
        bool isPsy,
      BuildContext context}) async {
    await AccountController.updateCurrentPsyInformation(
            firstname: firstname,
            lastname: lastname,
            birthdate: birthdate,
            geolocation: "",
            description: description,
            profileId : profileId,
            isPsy : isPsy, context: context);
  }
}
