import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:flutter/cupertino.dart';

class Psychologist extends User {
  String firstName;
  String lastName;
  String geolocation;

  Psychologist.normalConstructor(
      {this.firstName,
      this.lastName,
      String profileId,
      String username,
      String description,
      String birthdate,
      bool isPsy = true,
      int level,
      String email,
      String skin = "1AAAA_1AAAA_1AAAA",
      this.geolocation =""})
      : super(profileId, username, description, birthdate, isPsy, level, email,
            skin, geolocation);

  Psychologist.defaultConstructor({
    this.firstName = "",
    this.lastName = "",
    String profileId = "",
    String username = "",
    String description = "",
    String birthdate = "",
    bool isPsy = true,
    int level = 0,
    String email = "",
    String skin = "1AAAA_1AAAA_1AAAA",
    this.geolocation = "",
  }) : super(profileId, username, description, birthdate, isPsy, level, email,
            skin, geolocation);

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['user']['username'],
      birthdate: json['birthdate'],
      description: json['description'],
      profileId: json['id'],
      level: _determineLevelWithXp(json['user']['xp']),
      email: json['email'],
      skin:
          json['user']['skin'].toString().isEmpty ? "1AAAA_1AAAA_1AAAA" : json['user']['skin'],
      geolocation: json['geolocation'] == null ? "" : json['geolocation']
    );
  }

  static int _determineLevelWithXp(int xp) {
    return (xp / 100).floor() + 1;
  }

  factory Psychologist.fromJsonForSearch(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
        birthdate: json['birthdate'],
        description: json['description'],
        username: json['user']['username'],
        profileId: json['id'],
        skin: json['user']['skin'].toString().isEmpty
            ? "1AAAA_1AAAA_1AAAA"
            : json['user']['skin'],
        geolocation: json['geolocation'] ==  null ? "" : json['geolocation']);
  }

  Future<void> getUserProfile({@required String userID, @required BuildContext context}) async {
    await AccountController.getCurrentPsyInformation(psyId : userID, context : context)
        .then((userProfileResult) {
      this.firstName = userProfileResult.firstName;
      this.lastName = userProfileResult.lastName;
      this.birthdate = userProfileResult.birthdate;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.profileId = userProfileResult.profileId;
      this.level = userProfileResult.level;
      this.email = userProfileResult.email;
      this.skin = userProfileResult.skin;
      this.geolocation = userProfileResult.geolocation;
    });
  }

  Future<void> updateProfile(
      {String firstName,
      String lastName,
      String birthDate,
      String geolocation,
      String description,
      String profileId,
      BuildContext context}) async {
    await AccountController.updateCurrentPsyInformation(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        geolocation:geolocation,
        description: description,
        profileId: profileId,
        context: context);
  }
}
