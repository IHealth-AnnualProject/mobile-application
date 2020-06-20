import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustomBetsBi extends StatelessWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String labelText;
  final int maxLines;
  final TextInputType keyBoardType;
  final bool filled;
  final Color fillColor;
  final String hintText;

  TextFormFieldCustomBetsBi(
      {@required this.obscureText,
      @required this.textAlign,
      @required this.controller,
      @required this.validator,
      @required this.labelText,
      @required this.filled,
      @required this.fillColor,
      @required this.hintText,
      this.maxLines = 1,
      this.keyBoardType = TextInputType.text,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscureText,
      controller: this.controller,
      textAlign: this.textAlign,
      validator: this.validator,
      maxLines: this.maxLines,
      keyboardType: this.keyBoardType,
      decoration: InputDecoration(
          labelText: this.labelText,
          filled: this.filled,
          fillColor: this.fillColor,
          hintText: this.hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
  }
}
