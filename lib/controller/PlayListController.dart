import 'dart:convert';

import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:flutter/cupertino.dart';

class PlayListController {
  static Future<List<PlayList>> getAllPlayList({
    @required BuildContext context,
  }) async {
    HttpManager httpManager = new HttpManager(path: "playlist");
    await httpManager.get();
    List<PlayList> playlists = new List<PlayList>();
    print("GetAllPlayList :" + httpManager.response.statusCode.toString());
    if (httpManager.response.body.isNotEmpty) {
      Iterable listFromJson = json.decode(httpManager.response.body);
      playlists.addAll(
          listFromJson.map((model) => PlayList.fromJson(model)).toList());
    }
    return playlists;
  }

  static Future<PlayList> getPlayList({
    @required BuildContext context,
    @required String playListId,
  }) async {
    HttpManager httpManager = new HttpManager(path: "playlist/$playListId");
    await httpManager.get();
    print("GetPlayList :" + httpManager.response.request.toString());
    return PlayList.fromJson(json.decode(httpManager.response.body));
  }

  static Future<PlayList> createNewPlayList({
    @required BuildContext context,
    @required String playListName,
  }) async {
    HttpManager httpManager = new HttpManager(
        path: "playlist",
        map: <String, dynamic>{"name": playListName, "musics": []});
    await httpManager.post();
    print("CreateNewPlayListWithMusic :" +
        httpManager.response.statusCode.toString());
    return PlayList.fromJson(json.decode(httpManager.response.body));
  }

  static addSongToPlayList({
    @required BuildContext context,
    @required String playlistId,
    @required String musicId,
  }) async {
    HttpManager httpManager = new HttpManager(
      path: "playlist/$playlistId/addMusic/$musicId",
    );
    await httpManager.postWihtoutBody();
    print("addSongToPlayList :" + httpManager.response.request.toString());
  }
}
