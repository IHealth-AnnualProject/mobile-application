import 'package:betsbi/model/song.dart';
import 'package:flutter/cupertino.dart';

class PlayList {
   String id;
   String name;
  List<Song> songs;

  PlayList({@required this.id, @required this.name, @required this.songs});

  PlayList.defaultConstructor(){
    this.id  ="";
    this.name ="";
    this.songs = [];
  }

  factory PlayList.fromJson(Map<String, dynamic> json) {
    var musics = json['musics'] as List;
    List<Song> musicList = musics.map((i) => Song.fromJson(i)).toList();
    return PlayList(
      id: json['id'],
      name: json['name'],
      songs: musicList,
    );
  }
}
