import 'package:betsbi/controller/AmbianceController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MusicPlayerCardItem extends StatelessWidget {
  final String songName;
  final Icon icon;
  final String duration;
  final String path;

  MusicPlayerCardItem(
      {@required this.songName,
      this.duration,
      @required this.path,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.35,
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: icon == null ? Icon(Icons.music_note) : icon,
          title: Text(songName),
          onTap: () => AmbianceController.listenMusic(
              songName: this.songName, path: this.path, context: context),
          trailing: Icon(Icons.play_arrow),
          subtitle: this.duration != null ? Text(duration) : Text(""),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: SettingsManager.mapLanguage["AddToPlaylist"],
          color: Colors.blue,
          icon: Icons.add,
          onTap: () => print("archive"),
        ),
      ],
    );
  }
}
