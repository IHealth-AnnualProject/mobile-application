import 'package:flutter/cupertino.dart';

class Response{
  final int statusCode;
  final String content;
  bool isOk;

  Response({@required this.statusCode, @required this.content});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      statusCode: json['statusCode'],
      content: json['message'],
    );
  }

  void setIsOk(bool value) => this.isOk = value;
}