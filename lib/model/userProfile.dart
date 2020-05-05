import 'package:betsbi/controller/AccountController.dart';

class UserProfile {
  String firstName;
  String lastName;
  String age;
  String description;
  String username;
  bool isPsy;
  String userProfileId;

  UserProfile.normalConstructor(
      {this.firstName,
      this.lastName,
      this.age,
      this.description,
      this.username,
      this.isPsy,
      this.userProfileId});

  UserProfile.defaultConstructor(
      {this.firstName = "",
      this.lastName = "",
      this.age = "",
      this.description = "",
      this.username = "",
      this.isPsy = false,
      this.userProfileId = ""});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.normalConstructor(
        firstName: json['first_name'],
        lastName: json['last_name'],
        age: json['age'],
        description: json['description'],
        username: json['user']['username'],
        isPsy: json['user']['isPsy'],
        userProfileId: json['user']['id']);
  }

  Future<UserProfile> getUserProfile({String userID}) async {
     await AccountController.getCurrentUserInformation(userID)
        .then((userProfileResult) {
      this.firstName = userProfileResult.firstName;
      this.lastName = userProfileResult.lastName;
      this.age = userProfileResult.age;
      this.description = userProfileResult.description;
      this.username = userProfileResult.username;
      this.userProfileId = userProfileResult.userProfileId;
      this.isPsy = userProfileResult.isPsy;
    });
  }

  Future<bool> updateUserProfile(
      {String firstname,
      String lastname,
      int age,
      String geolocation,
      String description}) async {
    bool isUpdated = false;
    await AccountController.updateCurrentUserInformation(
            firstname: firstname,
            lastname: lastname,
            age: age,
            geolocation: "",
            description: description)
        .then((worked) => isUpdated = worked);
    return isUpdated;
  }
}
