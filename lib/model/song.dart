class Song {
  String songName;
  String path;
  bool open;

  Song.defaultConstructor({this.open = false});

  Song({this.songName, this.path, this.open = false});

  bool isOpen() => open;
  void setOpen(bool value) => this.open = value;
}
