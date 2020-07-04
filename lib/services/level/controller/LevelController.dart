import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/account/model/accessorie.dart';
import 'package:betsbi/services/account/model/face.dart';
import 'package:betsbi/services/account/model/skinColor.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelController {
  static int determineLevelWithXp(int xp) => (xp / 100).floor() + 1;

  static bool isLevelSuperior(int currentXp, int futureXp) =>
      determineLevelWithXp(futureXp) > determineLevelWithXp(currentXp);

  static Future<int> getCurrentUserXp(
      {@required String userID, @required BuildContext context}) async {
    HttpManager httpManager =
        HttpManager(path: 'userProfile/$userID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseAndReturnTheDesiredElement(
      elementToReturn: UserProfile.fromJson(
        json.decode(httpManager.response.body),
      ).xp,
    );
  }

  static Future<List<Widget>> getAllUnlockedOutfits(
      {@required int level}) async {
    Map<String, dynamic> mapSkin =
        await JsonParserManager.parseJsonFromAssetsToMap(
            "assets/skin/skin.json");
    List<Face> faces = List<Face>();
    List<SkinColor> skinColors = List<SkinColor>();
    List<Accessory> accessories = List<Accessory>();
    mapSkin["Face"].forEach((face) {
      face.forEach((faceKey, faceValue) =>
          faces.add(Face.fromJson(key: faceKey, value: faceValue)));
    });
    mapSkin["SkinColor"].forEach((color) {
      color.forEach((colorKey, colorValue) =>
          skinColors.add(SkinColor.fromJson(key: colorKey, value: colorValue)));
    });
    mapSkin["Accessories"].forEach((accessory) {
      accessory.forEach((accessoryKey, accessoryValue) => accessories
          .add(Accessory.fromJson(key: accessoryKey, value: accessoryValue)));
    });
    faces.removeWhere((face) => face.level != level);
    skinColors.removeWhere((color) => color.level != level);
    accessories.removeWhere((accessory) => accessory.level != level);
    List<Widget> unlockedOutFit = List<Widget>();
    unlockedOutFit.addAll(_fromFaceToListTile(faces: faces));
    unlockedOutFit.addAll(_fromAccessoryToListTile(accessories: accessories));
    unlockedOutFit.addAll(_fromSkinColorToListTile(skinColors: skinColors));
    return unlockedOutFit;
  }

  static List<Widget> _fromFaceToListTile({@required List<Face> faces}) {
    List<ListTile> faceListTile = List<ListTile>();
    if (faces.isEmpty) return faceListTile;
    faces.forEach(
      (face) {
        faceListTile.add(
          ListTile(
            title: Text(face.image.replaceAll(".png", "")),
            leading: Container(
              height: 100 ,
              width: 100,
              child:  Image.asset("assets/skin/face/" + face.image),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
    return faceListTile;
  }

  static List<Widget> _fromAccessoryToListTile(
      {@required List<Accessory> accessories}) {
    List<ListTile> accessoryListTile = List<ListTile>();
    if (accessories.isEmpty) return accessoryListTile;
    accessories.forEach(
      (accessory) {
        accessoryListTile.add(
          ListTile(
            title: Text(accessory.image.replaceAll(".png", "")),
            leading: Container(
              height: 100 ,
              width: 100,
              child:  Image.asset("assets/skin/accessories/" + accessory.image),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
    return accessoryListTile;
  }

  static List<Widget> _fromSkinColorToListTile(
      {@required List<SkinColor> skinColors}) {
    List<ListTile> skinColorListTile = List<ListTile>();
    if (skinColors.isEmpty) return skinColorListTile;
    skinColors.forEach(
      (skinColor) {
        skinColorListTile.add(
          ListTile(
            title: Text(skinColor.code),
            leading: Container(
              height: 100 ,
              width: 100,
              decoration: new BoxDecoration(
                color: skinColor.colorTable,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
    return skinColorListTile;
  }
}
