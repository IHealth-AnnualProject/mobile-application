abstract class User {
  String birthdate;
  String description;
  String username;
  String profileId;
  bool isPsy;
  int level;

  User(this.profileId, this.username, this.description, this.birthdate, this.isPsy, this.level);

  Future<void> getUserProfile({String userID});

}
