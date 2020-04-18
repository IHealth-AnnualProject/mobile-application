import '../feelings.dart';

class User {
  String name;
  String type;
  int id;
  int level;
  List<Feelings> feelings;

  User(this.id, this.name, this.type, this.level);
}