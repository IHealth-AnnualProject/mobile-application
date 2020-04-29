import 'package:betsbi/controller/AccountController.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final String age;
  final String description;

  UserProfile.normalConstructor({this.firstName, this.lastName, this.age, this.description});

  UserProfile.defaultConstructor(
      {this.firstName = "", this.lastName = "", this.age = "", this.description = ""});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      description:  json['description'],
    );
  }

  UserProfile getUserProfile() {
    UserProfile userProfile;
    AccountController.getCurrentUserInformation()
        .then((userProfileResult) => userProfile = userProfileResult);
    return userProfile;
  }

  bool updateUserProfile(
      {String firstname, String lastname, int age, String geolocation, String description}) {
    bool isUpdated = false;
    AccountController.updateCurrentUserInformation(
            firstname: firstname, lastname: lastname, age: age, geolocation: "", description: description)
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
