class Memo {
  int id;
  String title;
  String dueDate;

  Memo({this.id, this.title, this.dueDate});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'dueDate': dueDate,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Memo{id: $id, title: $title, dueDate: $dueDate}';
  }
}
