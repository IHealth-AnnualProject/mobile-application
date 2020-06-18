
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:betsbi/model/face.dart';
import 'package:betsbi/model/skinColor.dart';
import 'package:betsbi/service/JsonParserManager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('List shoud have element on index 1', () {
    List<Audio> audios = new List<Audio>(2);

    audios[1] = new Audio.file("path");

    expect(audios[1].path, "path");
  });

  test('Integer should be 25 in given String', () {
    String toTest = "25AARA";

    final digits = RegExp(r'[0-9]*', multiLine: true);

    expect(int.parse(digits.firstMatch(toTest).group(0)), 25);
  });
  test('Integer should be AARA in given String', () {
    String toTest = "25AARA";

    final digits = RegExp(r'[A-Z]*$', multiLine: true);

    expect(digits.firstMatch(toTest).group(0), "AARA");
  });

  test('Should list of Face contain face1.png', () async {
    List<Face> faces = new List<Face>();

    Map<String, dynamic> mapSkin = await JsonParserManager.parseJsonFromAssetsToMap("assets/skin/skin.json");
    faces = new List<Face>();
    mapSkin["Face"].forEach((face) {
      face.forEach((faceKey, faceValue) => faces.add(Face.fromJson(key: faceKey, value: faceValue)));
    });

    expect(faces.any((face) => face.image == 'face1.png'), true);
  });

  test('Should index of list of face be at 0', () async {
    String codeSkin = "1AAAA_1AAAA_1AAAA";
    int defaultFaceIndex = 9999;
    List<Face> faces = new List<Face>();
    Map<String, dynamic> mapSkin = await JsonParserManager.parseJsonFromAssetsToMap("assets/skin/skin.json");
    faces = new List<Face>();
    mapSkin["Face"].forEach((face) {
      face.forEach((faceKey, faceValue) => faces.add(Face.fromJson(key: faceKey, value: faceValue)));
    });
    defaultFaceIndex = faces.lastIndexWhere((face) => face.level.toString()  + face.code == codeSkin.split("_")[0]);

    expect(defaultFaceIndex, 0);
  });

  test('Should opacity be at 1', () async {
    String codeSkin = "1AAAA_1AAAA_1AAAA";
    int defaultColorIndex = 9999;
    List<SkinColor> colors = new List<SkinColor>();
    Map<String, dynamic> mapSkin = await JsonParserManager.parseJsonFromAssetsToMap("assets/skin/skin.json");
    mapSkin["SkinColor"].forEach((skinColor) {
      skinColor.forEach((colorKey, colorValue) => colors.add(SkinColor.fromJson(key: colorKey, value: colorValue)));
    });
    defaultColorIndex = colors.lastIndexWhere((color) => color.level.toString()  + color.code == codeSkin.split("_")[0]);
    expect(colors[defaultColorIndex].colorTable.opacity, 1.0);
  });
}
