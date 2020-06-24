import 'package:betsbi/animation/CurvedAnimation.dart';
import 'package:betsbi/presentation/ColorPaletteRelaxing.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/relaxing/view/RelaxingView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelaxingState extends State<RelaxingPage> with TickerProviderStateMixin, WidgetsBindingObserver {
  CustomCurvedAnimation curvedAnimation;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  startAnimation()
  {
    curvedAnimation = new CustomCurvedAnimation.withoutCurve(
        begin: 0.6, end: 1, duration: Duration(seconds: 3), vsync: this);
    curvedAnimation.addListenerOnAnimation(
          (status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              restartAnimation();
            });
          }
        }
      },
    );
    curvedAnimation.startAnimation();
  }
  restartAnimation()
  {
    curvedAnimation = new CustomCurvedAnimation.withoutCurve(
        begin: 1, end: 0.6, duration: Duration(seconds: 3), vsync: this);
    curvedAnimation.addListenerOnAnimation(
          (status) {
        if (status == AnimationStatus.completed) {
          Color firstColor = ColorPaletteRelaxing.firstPalette.first;
          ColorPaletteRelaxing.firstPalette.removeAt(0);
          ColorPaletteRelaxing.firstPalette.add(firstColor);
          if (mounted) {
            setState(() {
              startAnimation();
            });
          }
        }
      },
    );
    curvedAnimation.startAnimation();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startAnimation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    curvedAnimation.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () => Navigator.of(context).pop(),
        child: FadeTransition(
          opacity: curvedAnimation.animation,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorPaletteRelaxing.firstPalette.first,
          ),
        ),
    );
  }


}
