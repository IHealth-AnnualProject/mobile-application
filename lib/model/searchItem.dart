import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/model/song.dart';
import 'package:betsbi/model/user.dart';
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