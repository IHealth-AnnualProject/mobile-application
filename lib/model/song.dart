class Song {
  String songName;
  String path;
  bool open;
  String id;
  String duration;
  String linkDownload;

  Song.defaultConstructor({this.open = false});

  Song.fromAPI({this.id, this.songName, this.duration, this.linkDownload});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song.fromAPI(
      id: json['id'],
      songName: json['name'],
      duration: Duration(seconds: json['duration']).inMinutes.toString() +
          ":" +
          Duration(seconds: json['duration'] % 60).inSeconds.toString(),
      linkDownload: json['linkDownload'],
    );
  }

  Song({this.songName, this.path, this.open = false});

  String toSting() {
    return "tostring";
  }

  bool isOpen() => open;
  void setOpen(bool value) => this.open = value;
}
