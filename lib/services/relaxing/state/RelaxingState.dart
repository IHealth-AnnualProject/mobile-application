import 'package:betsbi/animation/CurvedAnimation.dart';
import 'package:betsbi/presentation/ColorPaletteRelaxing.dart';
import 'package:betsbi/services/relaxing/view/AmbianceView.dart';
import 'package:betsbi/services/relaxing/view/RelaxingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelaxingState extends State<RelaxingPage> with TickerProviderStateMixin {
  CustomCurvedAnimation curvedAnimation;

  //todo add on resume


  @override
  void initState() {
    super.initState();
    curvedAnimation = new CustomCurvedAnimation.withoutCurve(
        begin: 0.2, end: 1, duration: Duration(seconds: 4), vsync: this);
    curvedAnimation.addListenerOnAnimation(
      (status) {
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
      },
    );
    curvedAnimation.startAnimation();
  }

  @override
  void dispose() {
    curvedAnimation.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onDoubleTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AmbiancePage(),
          ),
          (Route<dynamic> route) => false,
        ),
        child: FadeTransition(
          opacity: curvedAnimation.animation,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorPaletteRelaxing.firstPalette.first,
          ),
        ),
      ),
      onWillPop: _willPopCallback,
    );
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => AmbiancePage(),
      ),
      (Route<dynamic> route) => false,
    );
    return true; // return true if the route to be popped
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RelaxingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: curvedAnimation.animation,
          child: child,
        );
      },
    );
  }
}
