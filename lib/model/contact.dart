class Contact {
  String userId;
  String username;
  bool isPsy;
  int newMessage;

  Contact({this.isPsy, this.userId, this.username, this.newMessage = 0});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        isPsy: json['isPsy'],
        username: json['username'],
        userId: json['id']);
  }
}
