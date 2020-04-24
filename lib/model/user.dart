import 'feelings.dart';

class User {
  String name;
  String email;
  String type;
  int id;
  int level;
  List<Feelings> feelings;

  //User({this.id, this.name, this.email, this.level});

  User(this.id, this.name, this.email, this.level);

  /*factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        level: json['level']);
  }*/
}
