import 'package:flutter/cupertino.dart';

class AvatarSkinWidget extends StatelessWidget {
  final String accessoryImage;
  final String faceImage;
  final Color skinColor;

  AvatarSkinWidget(
      {@required this.accessoryImage,
      @required this.faceImage,
      @required this.skinColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset("assets/skin/face/" + faceImage),
            bottom: 50,
            top: 50,
            left: 10,
            right: 10,
          ),
          Positioned(
            child: Image.asset("assets/skin/accessories/" + accessoryImage),
            height: 60,
            right: 2,
            width: 60,
            bottom: 5,
          ),
        ],
      ),
      decoration: new BoxDecoration(
        color: skinColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
