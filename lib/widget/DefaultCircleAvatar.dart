import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget{
  final String imagePath;

  DefaultCircleAvatar({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 6.0),
            blurRadius: 40.0,
          ),
        ],
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(this.imagePath),
        ),
      ),
    );
  }


}