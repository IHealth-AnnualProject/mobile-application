import 'package:betsbi/controller/AccountController.dart';
import 'package:betsbi/model/user.dart';

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
      bool isPsy = true})
      : super(profileId, username, description, birthdate, isPsy);

  Psychologist.defaultConstructor(
      {this.firstName = "",
      this.lastName = "",
      String profileId = "",
      String username = "",
      String description = "",
      String birthdate = "",
      bool isPsy = true})
      : super(profileId, username, description, birthdate, isPsy);

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['user']['username'],
        birthdate: json['birthdate'],
        description: json['description'],
        profileId: json['id']);
  }

  factory Psychologist.fromJsonForSearch(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
        birthdate: json['birthdate'],
        description: json['description'],
        username: json['user']['username'],
        profileId: json['id']);
  }

  Future<void> getUserProfile({String userID}) async {
    await AccountController.getCurrentPsyInformation(userID)
        .then((userProfileResult) {
      this.firstName = userProfileResult.firstName;
      this.lastName = userProfileResult.lastName;
      this.birthdate = userProfileResult.birthdate;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.profileId = userProfileResult.profileId;
    });
  }

  bool updatePsyProfile(
      {String firstname,
      String lastname,
      DateTime birthdate,
      String geolocation,
      String description}) {
    bool isUpdated = false;
    AccountController.updateCurrentUserInformation(
            firstname: firstname,
            lastname: lastname,
            birthdate: birthdate,
            geolocation: "",
            description: description)
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
