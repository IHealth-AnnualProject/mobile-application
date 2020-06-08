import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/model/song.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/MusicPlayerButtonPlay.dart';
import 'package:betsbi/widget/MusicPlayerProgressIndicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AmbianceController {
  static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  static Flushbar musicFlush;

  static Flushbar musicPlayerFlushBar({String songName, String path}) {
    return musicFlush = Flushbar<String>(
      backgroundColor: Colors.white,
      isDismissible: false,
      titleText: Text(
        songName,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(0, 157, 153, 1), fontWeight: FontWeight.bold),
      ),
      messageText: MusicPlayerProgressIndicator(),
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        Icons.music_note,
        color: Color.fromRGBO(0, 157, 153, 1),
      ),
      mainButton: MusicPlayerButtonPlay(),
    );
  }

  static Future<void> listenMusic(
      {String songName, String path, BuildContext context}) async {
    if (musicFlush != null && musicFlush.isShowing()) {
      musicFlush.dismiss();
      assetsAudioPlayer.stop();
    }
    await assetsAudioPlayer.open(Audio.file(path,),);
    musicFlush = musicPlayerFlushBar(songName: songName, path: path);
    musicFlush.show(context);
  }

  static Future<List<Song>> getAllSongs({BuildContext context}) async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") + 'music/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
    if (response.statusCode >= 100 && response.statusCode < 400) {
      List<Song> songs = new List<Song>();
      Iterable listSongs = json.decode(response.body);
      songs.addAll(listSongs.map((model) => Song.fromJson(model)).toList());
      return songs;
    } else {
      return null;
    }
  }

  static Future<http.Response> downloadFile({String musicId}) async{
    http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") + 'music/$musicId/download',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
        'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
    return response;
  }
}
