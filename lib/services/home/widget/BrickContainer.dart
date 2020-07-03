import 'dart:ui';

import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/home/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrickContainer extends StatelessWidget {
  final String textBrick;
  final StatefulWidget destination;
  final String image;

  const BrickContainer(
      {this.textBrick,
      this.destination,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: GestureDetector(
          onTap: () {
            if (this.destination != null)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => this.destination)).whenComplete(
                    () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(isPsy: SettingsManager.applicationProperties.isPsy() == 'true' ? true : false,),
                  ),
                      (Route<dynamic> route) => false,
                ),
              );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                "assets/" + this.image,
              ),
              Text(
                this.textBrick,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(2, 168, 168, 1), fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
