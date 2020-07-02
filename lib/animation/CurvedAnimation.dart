import 'package:flutter/material.dart';

class CustomCurvedAnimation {
  Animation<double> animation;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;

  CustomCurvedAnimation.withCurve({
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
    this.curvedAnimation =
        CurvedAnimation(curve: curves, parent: this.animationController);
    this.animation =
        Tween<double>(begin: begin, end: end).animate(this.curvedAnimation);
  }

  CustomCurvedAnimation.withoutCurve({
    TickerProvider vsync,
    Duration duration,
    double begin,
    double end,
  }) {
    this.animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );
    this.animation =
        Tween<double>(begin: begin, end: end).animate(this.animationController);
  }

  void startAnimation() {
    this.animationController.isCompleted
        ? this.animationController.reverse()
        : this.animationController.forward();
  }

  void addListenerOnAnimation(void Function(AnimationStatus) function) {
    this.animation.addStatusListener(function);
  }
}
