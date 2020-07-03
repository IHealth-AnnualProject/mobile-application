import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegalPart extends StatefulWidget {
  final String title;
  final String content;

  LegalPart({@required this.title, @required this.content});

  @override
  State<LegalPart> createState() => _LegalPartState();
}

class _LegalPartState extends State<LegalPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(0, 157, 153, 1)),
        ),
        Divider(
          thickness: 2,
        ),
        Text(
          this.widget.content,
          style: TextStyle(
              fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
