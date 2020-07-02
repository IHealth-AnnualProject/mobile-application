import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:betsbi/services/playlist/model/song.dart';
import 'package:flutter/cupertino.dart';

class SearchItem {
  String title;
  String subtitle;
  Widget leading;
  Exercise exercise;
  User user;
  Song song;
  bool contactButton;

  SearchItem.userItem({this.title, this.subtitle, this.leading, this.user, this.contactButton = true});

  SearchItem.exerciseItem({this.title, this.subtitle, this.leading, this.exercise, this.contactButton = false});

  SearchItem.songItem({this.title, this.subtitle, this.leading, this.song, this.contactButton = false});
}