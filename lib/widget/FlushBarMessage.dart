import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlushBarMessage extends StatelessWidget {
  final String content;
  final IconData icons;
  final Color color;

  FlushBarMessage({this.content, this.icons, this.color});

  FlushBarMessage.errorMessage({@required this.content, this.icons = Icons.not_interested, this.color = Colors.red});


  FlushBarMessage.informationMessage({@required this.content, this.icons = Icons.info, this.color = Colors.green});


  FlushBarMessage.goodMessage({@required this.content, this.icons = Icons.done_outline, this.color = Colors.yellow});

  Flushbar flushbar() {
    return Flushbar(
        icon: Icon(
          this.icons,
          color: this.color,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        message: this.content,
        duration: Duration(seconds: 1));
  }

  void showFlushBar(BuildContext context) {
    flushbar().show(context);
  }

  void showFlushBarAndNavigateAndRemove(
      BuildContext context, Widget destination) {
    flushbar().show(context).then((_) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => destination),
          (Route<dynamic> route) => false,
        ));
  }

  void showFlushBarAndDo(
      BuildContext context, Function afterShow) {
    flushbar().show(context).then((_) => afterShow());
  }

  @override
  Widget build(BuildContext context) {
    return flushbar();
  }
}
