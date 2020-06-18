import 'package:flutter/cupertino.dart';

class Face {
  int level;
  String code;
  String image;

  Face.defaultConstructor(
      {@required this.level, @required this.code, @required this.image});

  factory Face.fromJson({@required String key, @required String value}) {
    int level = _decryptKeyToGetDigits(key);
    String code = _decryptKeyToGetStrings(key);
    return Face.defaultConstructor(level: level, code: code, image: value);
  }

  static int _decryptKeyToGetDigits(String key) {
    final digits = RegExp(r'[0-9]*', multiLine: true);
    return int.parse(digits.firstMatch(key).group(0));
  }

  static String _decryptKeyToGetStrings(String key) {
    final digits = RegExp(r'[A-Z]*$', multiLine: true);
    return digits.firstMatch(key).group(0);
  }
}
