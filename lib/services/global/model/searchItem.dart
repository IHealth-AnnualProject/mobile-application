import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/playlist/model/song.dart';
import 'package:flutter/cupertino.dart';

class SearchItem {
  String title;
  String subtitle;
  Icon trailing;
  Exercise exercise;
  User user;
  Song song;

  SearchItem.userItem({this.title, this.subtitle, this.trailing, this.user});

  SearchItem.exerciseItem({this.title, this.subtitle, this.trailing, this.exercise});

  SearchItem.songItem({this.title, this.subtitle, this.trailing, this.song});
}