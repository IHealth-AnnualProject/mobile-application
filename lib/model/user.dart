abstract class User {
  String birthdate;
  String description;
  String username;
  String profileId;
  bool isPsy;

  User(this.profileId, this.username, this.description, this.birthdate, this.isPsy);

  Future<void> getUserProfile({String userID});

}
