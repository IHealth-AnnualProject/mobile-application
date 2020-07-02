import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/playlist/model/playlist.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class PlayListController {
  static Future<List<PlayList>> getAllPlayList({
    @required BuildContext context,
  }) async {
    HttpManager httpManager =
        new HttpManager(path: "playlist", context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      context: context,
      response: httpManager.response,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => fromJsonToPlayListList(httpManager),elementToReturnIfFalse: new List<PlayList>());
  }

  static List<PlayList> fromJsonToPlayListList(HttpManager httpManager) {
    List<PlayList> playlists = new List<PlayList>();
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
    HttpManager httpManager =
        new HttpManager(path: "playlist/$playListId", context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context);
    return responseManager.checkResponseRetrieveInformationWithAFunction(
      toReturn: () => PlayList.fromJson(
        json.decode(httpManager.response.body),
      ),elementToReturnIfFalse: PlayList.defaultConstructor()
    );
  }

  static Future<void> createNewPlayList({
    @required BuildContext context,
    @required String playListName,
  }) async {
    HttpManager httpManager = new HttpManager(
        path: "playlist",
        map: <String, dynamic>{"name": playListName, "musics": []},
        context: context);
    await httpManager.post();
    print("CreateNewPlayListWithMusic :" +
        httpManager.response.statusCode.toString());
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context);
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(successMessage: SettingsManager.mapLanguage["PlayListCreated"]);
  }

  static Future<void> addSongToPlayList({
    @required BuildContext context,
    @required String playlistId,
    @required String musicId,
  }) async {
    HttpManager httpManager = new HttpManager(
        path: "playlist/$playlistId/addMusic/$musicId", context: context);
    await httpManager.postWithoutBody();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context);
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(successMessage: SettingsManager.mapLanguage["AddSongToPlayList"]);
  }

  static Future<void> removeSongFromPlayList({
    @required BuildContext context,
    @required String playlistId,
    @required String musicId,
  }) async {
    HttpManager httpManager = new HttpManager(
        path: "playlist/$playlistId/deleteMusic/$musicId", context: context);
    await httpManager.delete();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context);
    return responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(successMessage: SettingsManager.mapLanguage["RemoveFromPlayList"]);
  }
}
