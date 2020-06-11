import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/state/PlayListState.dart';
import 'package:flutter/cupertino.dart';

class PlayListPage extends StatefulWidget{
  final PlayList playList;

  PlayListPage({@required this.playList});

  @override
  State<PlayListPage> createState() => PlayListState();

}