import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkinColor{
  int level;
  String code;
  Color colorTable;

  SkinColor.defaultConstructor({@required this.level, this.code, this.colorTable });

  factory SkinColor.fromJson({@required String key, @required dynamic value}) {
    int level = _decryptKeyToGetDigits(key);
    String code = _decryptKeyToGetStrings(key);
    Color color = _decryptValueToGetColors(value);
    return SkinColor.defaultConstructor(level: level, code: code, colorTable: color);
  }


  static int _decryptKeyToGetDigits(String key) {
    final digits = RegExp(r'[0-9]*', multiLine: true);
    return int.parse(digits.firstMatch(key).group(0));
  }

  static String _decryptKeyToGetStrings(String key) {
    final digits = RegExp(r'[A-Z]*$', multiLine: true);
    return digits.firstMatch(key).group(0);
  }

  static Color _decryptValueToGetColors(dynamic value) {
    return Color.fromRGBO(value[0], value[1], value[2], double.parse(value[3].toString()));
  }

}