import 'package:betsbi/controller/AccountController.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final int age;

  UserProfile.normalConstructor({this.firstName, this.lastName, this.age});

  UserProfile.defaultConstructor(
      {this.firstName = "", this.lastName = "", this.age = 0});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
    );
  }

  UserProfile getUserProfile() {
    UserProfile userProfile;
    AccountController.getCurrentAccountInformation()
        .then((userProfileResult) => userProfile = userProfileResult);
    return userProfile;
  }

  bool updateUserProfile(
      {String firstname, String lastname, int age, String geolocation}) {
    bool isUpdated = false;
    AccountController.updateCurrentUserInformation(
            firstname: firstname, lastname: lastname, age: age, geolocation: "")
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
