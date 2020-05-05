import 'package:betsbi/controller/AccountController.dart';

class Psychologist {
  String firstName;
  String lastName;
  String age;
  String description;
  String username;

  Psychologist.normalConstructor(
      {this.firstName,
      this.lastName,
      this.age,
      this.description,
      this.username});

  Psychologist.defaultConstructor(
      {this.firstName = "",
      this.lastName = "",
      this.age = "",
      this.description = "",
      this.username = ""});

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist.normalConstructor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['user']['username'],
      age: json['age'],
      description: json['description'],
    );
  }

  Future<void> getUserProfile({String userID}) async {
    await AccountController.getCurrentUserInformation(userID)
        .then((userProfileResult) {
      this.firstName = userProfileResult.firstName;
      this.lastName = userProfileResult.lastName;
      this.age = userProfileResult.age;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
    });
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
