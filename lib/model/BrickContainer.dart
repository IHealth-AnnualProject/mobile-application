import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrickContainer extends StatelessWidget {
  final Color colorBrick;
  final String textBrick;
  final IconData iconBrick;
  final StatelessWidget destination;

  const BrickContainer(
      this.colorBrick, this.textBrick, this.iconBrick, this.destination);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.colorBrick,
      child: GestureDetector(
        onTap: () {
          if (this.destination != null)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => this.destination));
        },
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
        ),
      ),
    );
  }
}
