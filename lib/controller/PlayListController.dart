import 'dart:convert';

import 'package:betsbi/model/playlist.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class PlayListController {
  static Future<List<PlayList>> getAllPlayList({
    @required BuildContext context,
  }) async {
    HttpManager httpManager = new HttpManager(path: "playlist");
    await httpManager.get();
    print("GetAllPlayList :" + httpManager.response.statusCode.toString());
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      functionListToReturn: () => fromJsonToPlayListList(httpManager),
      elementToReturn: new List<PlayList>(),
    );
    return responseManager.checkResponseAndRetrieveListOfInformation();
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
    HttpManager httpManager = new HttpManager(path: "playlist/$playListId");
    await httpManager.get();
    print("GetPlayList :" + httpManager.response.request.toString());
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        functionFromJsonToReturn: () => PlayList.fromJson(
              json.decode(httpManager.response.body),
            ),
        elementToReturn: PlayList.defaultConstructor());
    return responseManager.checkResponseAndRetrieveInformationFromJson();
  }

  static Future<void> createNewPlayList({
    @required BuildContext context,
    @required String playListName,
  }) async {
    HttpManager httpManager = new HttpManager(
        path: "playlist",
        map: <String, dynamic>{"name": playListName, "musics": []});
    await httpManager.post();
    print("CreateNewPlayListWithMusic :" +
        httpManager.response.statusCode.toString());
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      successMessage: SettingsManager.mapLanguage["PlayListCreated"],
      context: context
    );
    responseManager.checkResponseAndPrintIt();
  }

  static Future<void> addSongToPlayList({
    @required BuildContext context,
    @required String playlistId,
    @required String musicId,
  }) async {
    HttpManager httpManager = new HttpManager(
      path: "playlist/$playlistId/addMusic/$musicId",
    );
    await httpManager.postWihtoutBody();
    print("addSongToPlayList :" + httpManager.response.request.toString());
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        successMessage: SettingsManager.mapLanguage["AddSongToPlayList"],
        context: context
    );
    responseManager.checkResponseAndPrintIt();
  }
}
