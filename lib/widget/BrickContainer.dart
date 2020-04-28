import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrickContainer extends StatelessWidget {
  final Color colorBrick;
  final String textBrick;
  final IconData iconBrick;
  final StatefulWidget destination;
  final String image;

  const BrickContainer({
      this.colorBrick, this.textBrick, this.iconBrick, this.destination, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (this.destination != null)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => this.destination));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              "assets/"+ this.image,
            ),
            new Text(
              this.textBrick,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
