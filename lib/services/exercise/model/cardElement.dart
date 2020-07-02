import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CardElement {
  int id;
  Color cardColor;
  String facePath;
  String accessoryPath;

  CardElement(
      {@required this.id,
      @required this.cardColor,
      @required this.facePath,
      @required this.accessoryPath});

  factory CardElement.fromJson(Map<String, dynamic> json) {
    return CardElement(
        id: json['Id'],
        cardColor: Color.fromRGBO( json['Color'][0], json['Color'][1],
            json['Color'][2], double.parse(json['Color'][3].toString())),
        accessoryPath: json['Accessory'],
        facePath: json['Face']);
  }
}
