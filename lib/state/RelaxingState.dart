import 'dart:async';

import 'package:betsbi/presentation/ColorPaletteRelaxing.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/view/RelaxingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelaxingState extends State<RelaxingView> with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.2, end: 1).animate(animation);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Color firstColor = ColorPaletteRelaxing.firstPalette.first;
        ColorPaletteRelaxing.firstPalette.removeAt(0);
        ColorPaletteRelaxing.firstPalette.add(firstColor);
        if (mounted) {
          Navigator.push(
            context,
            _createRoute(),
          );
        }
      }
    });
    animation.forward();
  }

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
    return GestureDetector(
      onDoubleTap: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AmbiancePage(),
        ),
        (Route<dynamic> route) => false,
      ),
      child: FadeTransition(
        opacity: _fadeInFadeOut,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorPaletteRelaxing.firstPalette.first,
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RelaxingView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: _fadeInFadeOut,
          child: child,
        );
      },
    );
  }
}
