class Contact {
  String userId;
  String username;
  bool isPsy;
  int newMessage;
  String skin;

  Contact(
      {this.isPsy, this.userId, this.username, this.newMessage = 0, this.skin});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      isPsy: json['isPsy'],
      username: json['username'],
      userId: json['id'],
      skin:
          json['skin'].toString().isEmpty ? "1AAAA_1AAAA_1AAAA" : json['skin'],
    );
  }

  setNewMessage(int value) => this.newMessage = value;
}
