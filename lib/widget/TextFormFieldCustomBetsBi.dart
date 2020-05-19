import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustomBetsBi extends StatelessWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String labelText;
  final TextInputType keyBoardType;
  final bool filled;
  final Color fillColor;
  final String hintText;

  TextFormFieldCustomBetsBi(
      {this.obscureText,
      this.textAlign,
      this.controller,
      this.validator,
      this.labelText,
      this.filled,
      this.fillColor,
      this.hintText,
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
