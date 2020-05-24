import 'dart:async';

import 'package:betsbi/presentation/ColorPaletteRelaxing.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/view/RelaxingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelaxingState extends State<RelaxingView> {
  void delay(BuildContext context) {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Color firstColor = ColorPaletteRelaxing.firstPalette.first;
        ColorPaletteRelaxing.firstPalette.removeAt(0);
        ColorPaletteRelaxing.firstPalette.add(firstColor);
        if (mounted) {
          Navigator.push(
            context,
            _createRoute(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return GestureDetector(
      onDoubleTap: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AmbiancePage(),
        ),
        (Route<dynamic> route) => false,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorPaletteRelaxing.firstPalette.first,
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RelaxingView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
