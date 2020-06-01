import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCurvedAnimation {
  Animation<double> animation;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;

  CustomCurvedAnimation({
    TickerProvider vsync,
    Duration duration,
    Curve curves,
    double begin,
    double end,
  }) {
    this.animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );
    this.curvedAnimation = CurvedAnimation(
        curve: Curves.easeInOut, parent: this.animationController);
    this.animation =
        Tween<double>(begin: begin, end: end).animate(this.curvedAnimation);
  }

  void startAnimation()
  {
    this.animationController.isCompleted
        ? this.animationController.reverse()
        : this.animationController.forward();
  }
}
