/// Used for badges
class NewMessage {
  int id;
  String userIdTo;
  String userIdFrom;

  NewMessage({this.userIdTo, this.userIdFrom});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userIdTo': userIdTo,
      'userIdFrom': userIdFrom
    };
    if (id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'NewMessage{userIdTo: $userIdTo, userIdFrom : $userIdFrom}';
  }
}