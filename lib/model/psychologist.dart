import 'package:betsbi/controller/AccountController.dart';

class Psychologist {
  final String firstName;
  final String lastName;
  final String age;
  final String description;

  Psychologist.normalConstructor(
      {this.firstName, this.lastName, this.age, this.description});

  Psychologist.defaultConstructor(
      {this.firstName = "",
      this.lastName = "",
      this.age = "",
      this.description = ""});

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      description: json['description'],
    );
  }

  Psychologist getUserProfile() {
    Psychologist userProfile;
    AccountController.getCurrentPsyInformation()
        .then((userProfileResult) => userProfile = userProfileResult);
    return userProfile;
  }

  bool updatePsyProfile(
      {String firstname,
      String lastname,
      int age,
      String geolocation,
      String description}) {
    bool isUpdated = false;
    AccountController.updateCurrentUserInformation(
            firstname: firstname,
            lastname: lastname,
            age: age,
            geolocation: "",
            description: description)
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
