import 'package:flutter/cupertino.dart';

class DefaultTextTitle extends StatelessWidget {
  final String title;

  DefaultTextTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 30),
    );
  }
}
