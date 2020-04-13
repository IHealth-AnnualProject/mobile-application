import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrickContainer extends StatelessWidget{
  final Color colorBrick;
  final String textBrick;
  final IconData iconBrick;

  const BrickContainer(this.colorBrick,this.textBrick, this.iconBrick);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: this.colorBrick,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              this.iconBrick,
              color: Colors.white,
              size: 150,
            ),
            new Text(
              this.textBrick,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }

}