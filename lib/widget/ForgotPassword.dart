import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatelessWidget {
  final String message;
  final String flushBarMessage;
  final IconData icons;

  ForgotPassword(this.message, this.flushBarMessage, this.icons);
  Flushbar<String> flush;


  var myController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextFormField textFormField(String text) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: myController,
      validator: (value) {
        return CheckController.checkEmail(value);
      },
      style: TextStyle(color: Colors.white),
      maxLines: 1,
      decoration: InputDecoration(
          hintText: text,
          fillColor: Colors.white10,
          filled: true,
          icon: Icon(
            Icons.label,
            color: Colors.grey[500],
          ),
          border: UnderlineInputBorder(),
          helperText: SettingsManager.mapLanguage["EnterMail"] != null
              ? SettingsManager.mapLanguage["EnterMail"]
              : "",
          helperStyle: TextStyle(color: Colors.grey),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    flush = Flushbar<String>(
      isDismissible: true,
      onStatusChanged: (FlushbarStatus status){
        if(status == FlushbarStatus.DISMISSED) {
          ContainerController.oneFlushBar = false;
        }
        if(status == FlushbarStatus.SHOWING) {
          ContainerController.oneFlushBar = true;
        }
        if(status == FlushbarStatus.IS_APPEARING){
          ContainerController.oneFlushBar = true;
        }
      },
      userInputForm: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          textFormField("Email"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MaterialButton(
              textColor: Colors.amberAccent,
              child: Text(SettingsManager.mapLanguage["Submit"] != null
                  ? SettingsManager.mapLanguage["Submit"]
                  : ""),
              onPressed: () {
                if (_formKey.currentState.validate())
                  flush.dismiss(myController.value.text);
              },
            ),
          ),
        ]),
      ),
      icon: Icon(
        this.icons,
        color: Colors.yellow,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      message: this.flushBarMessage,
    );
    return InkWell(
        onTap: () {
          if (!ContainerController.oneFlushBar) {
            flush.show(context).then((result) {
              if (result != null) {
                print(result);
              }
            });
          }
        },
        child: new Text(
          this.message,
          textAlign: TextAlign.center,
        ));
  }
}
