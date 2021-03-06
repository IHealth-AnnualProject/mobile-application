import 'package:flutter/cupertino.dart';

abstract class User {
  String birthdate;
  String description;
  String username;
  String profileId;
  bool isPsy;
  String email;
  String skin;
  int level;
  String geolocation;

  User(this.profileId, this.username, this.description, this.birthdate, this.isPsy, this.level, this.email, this.skin, this.geolocation);

  Future<void> getUserProfile({String userID, @required BuildContext context});

}
