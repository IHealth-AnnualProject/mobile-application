import 'package:flutter/cupertino.dart';

class AvatarSkinWidget extends StatelessWidget {
  final String accessoryImage;
  final String faceImage;
  final Color skinColor;
  final double bottomFace;
  final double topFace;
  final double leftFace;
  final double rightFace;
  final double heightAccessory;
  final double widthAccessory;
  final double bottomAccessory;
  final double rightAccessory;
  final String state;

  AvatarSkinWidget.accountConstructor(
      {@required this.accessoryImage,
      @required this.faceImage,
      @required this.skinColor, this.state = "Account", this.bottomFace = 50, this.topFace = 50, this.leftFace = 10, this.rightFace = 10, this.bottomAccessory = 5, this.heightAccessory = 60, this.widthAccessory = 60, this.rightAccessory = 2});

 AvatarSkinWidget.searchConstructor(
      {@required this.accessoryImage,
      @required this.faceImage,
      @required this.skinColor, this.state = "Search", this.bottomFace = 12.5, this.topFace = 12.5, this.leftFace = 2, this.rightFace = 2, this.bottomAccessory = 1, this.heightAccessory = 15, this.widthAccessory = 15, this.rightAccessory = 1});


 Container accountContainer(BuildContext context)
 {
   return Container(
     width: 150.0,
     height: 150.0,
     child: Stack(
       children: <Widget>[
         Positioned(
           child: Image.asset("assets/skin/face/" + faceImage),
           bottom: this.bottomFace,
           top: this.topFace,
           left: this.leftFace,
           right: this.rightFace,
         ),
         Positioned(
           child: Image.asset("assets/skin/accessories/" + accessoryImage),
           height: this.heightAccessory,
           right: this.rightAccessory,
           width: this.widthAccessory,
           bottom: this.bottomAccessory,
         ),
       ],
     ),
     decoration: new BoxDecoration(
       color: skinColor,
       shape: BoxShape.circle,
     ),
   );
 }

 Container searchContainer(BuildContext context)
 {
   return Container(
   width: 35,
   height:35,
   child: Stack(
     children: <Widget>[
       Positioned(
         child: Image.asset("assets/skin/face/" + faceImage),
         bottom: this.bottomFace,
         top: this.topFace,
         left: this.leftFace,
         right: this.rightFace,
       ),
       Positioned(
         child: Image.asset("assets/skin/accessories/" + accessoryImage),
         height: this.heightAccessory,
         right: this.rightAccessory,
         width: this.widthAccessory,
         bottom: this.bottomAccessory,
       ),
     ],
   ),
   decoration: new BoxDecoration(
     color: skinColor,
     shape: BoxShape.circle,
   ),
 );
 }

  @override
  Widget build(BuildContext context) {
   switch(this.state)
   {
     case "Account": return accountContainer(context);
     break;
     case "Search" : return searchContainer(context);
     break;
     default: return accountContainer(context);
     break;
   }
  }
}
