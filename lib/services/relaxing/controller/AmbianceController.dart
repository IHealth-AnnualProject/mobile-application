import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/manager/FileManager.dart';
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/playlist/model/song.dart';
import 'package:betsbi/tools/MusicPlayerButtonPlay.dart';
import 'package:betsbi/tools/MusicPlayerProgressIndicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AmbianceController {
  static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  static Flushbar musicFlush;
  static bool isMusicAvailable;

  static Flushbar musicPlayerFlushBar({@required String songName}) {
    return musicFlush = Flushbar<String>(
      backgroundColor: Colors.white,
      isDismissible: true,
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

  /*
   * Open Music File, and open FlushBar with current song
   * Close current FlushBar to stop the music if song currently played
   */
  static Future<void> listenMusic(
      {@required List<Audio> paths,
      @required String songName,
      @required BuildContext context,
      int startAtIndex = 0}) async {
    paths.removeWhere((element) => element.path == 'toTrash');
    if (musicFlush != null && musicFlush.isShowing()) {
      musicFlush.dismiss();
      assetsAudioPlayer.stop();
    }
    await assetsAudioPlayer.open(
      Playlist(audios: paths, startIndex: startAtIndex),
    );
    if (!assetsAudioPlayer.isLooping.value) assetsAudioPlayer.toggleLoop();
    musicFlush = musicPlayerFlushBar(songName: songName);
    musicFlush.show(context);
  }

  /*
  get all songs according to API
   */
  static Future<List<Song>> getAllSongs(
      {@required BuildContext context}) async {
    HttpManager httpManager = new HttpManager(path: 'music/', context: context);
    await httpManager.get();
    List<Song> songs = new List<Song>();
    ResponseManager responseManager = new ResponseManager(
      context: context,
      response: httpManager.response,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => _getSongsWithResponseBody(httpManager, songs),
        elementToReturnIfFalse: songs);
  }

  static List<Song> _getSongsWithResponseBody(
      HttpManager httpManager, List<Song> songs) {
    Iterable listSongs = json.decode(httpManager.response.body);
    songs.addAll(listSongs.map((model) => Song.fromJson(model)).toList());
    return songs;
  }

  static Future<http.Response> downloadFile(
      {@required String musicId, @required BuildContext context}) async {
    HttpManager httpManager =
        new HttpManager(path: 'music/$musicId/download', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(successMessage: SettingsManager.mapLanguage["DownloadedFile"]);
    return httpManager.response;
  }

  static Future<bool> checkIfSongAvailable(
      {@required String songName, @required String duration}) async {
    AssetsAudioPlayer _songToTestifWorking = new AssetsAudioPlayer();
    bool isMusicAvailable =
        await FileManager.checkIfFileExist(fileName: songName + ".mp3");
    String applicationPath = (await getApplicationDocumentsDirectory()).path;
    if (isMusicAvailable) {
      try {
        await _songToTestifWorking.open(
            Audio.file(applicationPath + "/" + songName + ".mp3"),
            autoStart: false);
      } on PlatformException {
        isMusicAvailable = false;
      } on IOException {
        isMusicAvailable = false;
      }
    }
    return isMusicAvailable;
  }

  static Future checkSongAndDownload(
      {@required String songName,
      @required String duration,
      @required String id,
      @required BuildContext context}) async {
    bool exist =
        await checkIfSongAvailable(songName: songName, duration: duration);
    if (!exist)
      await FileManager.downloadFile(
          musicId: id, fileName: songName + ".mp3", context: context);
  }

  /* static bool _checkDurationAreEquals(
      {@required Duration firstDuration, @required String secondDuration}) {
    bool areDurationTheSame = true;
    String musicDurationToCompare = Duration(seconds: firstDuration.inSeconds)
            .inMinutes
            .toString() +
        ":" +
        Duration(seconds: firstDuration.inSeconds % 60).inSeconds.toString();
    print("firstDuration" + musicDurationToCompare);
    print("secondDuration" + secondDuration);
    if (musicDurationToCompare != secondDuration) {
      areDurationTheSame = false;
    }
    return areDurationTheSame;
  }*/
}
