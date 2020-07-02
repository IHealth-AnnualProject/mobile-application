import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/model/accessorie.dart';
import 'package:betsbi/services/account/model/face.dart';
import 'package:betsbi/services/account/model/skinColor.dart';
import 'package:flutter/cupertino.dart';

class SkinController {
  static List<Face> faces = List<Face>();
  static List<SkinColor> skinColors = List<SkinColor>();
  static List<Accessory> accessories = List<Accessory>();

  static getSkinParametersFromJsonInList() async {
    Map<String, dynamic> mapSkin =
        await JsonParserManager.parseJsonFromAssetsToMap(
            "assets/skin/skin.json");
    faces = new List<Face>();
    skinColors = new List<SkinColor>();
    accessories = new List<Accessory>();
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
    return faces;
  }

  static Future<void> updateSkinForCurrentUser(
      {@required String skinCode, @required BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'user',
        context: context,
        map: <String, dynamic>{"skin": skinCode});
    await httpManager.patch();
    ResponseManager responseManager = ResponseManager(
        response: httpManager.response,
        context: context,);
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(successMessage: SettingsManager.mapLanguage["UpdatedSkin"]);
  }
}
