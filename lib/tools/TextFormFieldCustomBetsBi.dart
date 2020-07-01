import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustomBetsBi extends StatefulWidget {
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
  final bool child;

  TextFormFieldCustomBetsBi(
      {@required this.obscureText,
      @required this.textAlign,
      @required this.controller,
      @required this.validator,
      @required this.labelText,
      @required this.filled,
      @required this.fillColor,
      @required this.hintText,
      this.child = false,
      this.maxLines = 1,
      this.keyBoardType = TextInputType.text,
      Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TextFormFieldCustomBetsBiState();
}

class TextFormFieldCustomBetsBiState extends State<TextFormFieldCustomBetsBi> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = this.widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: this.widget.controller,
      textAlign: this.widget.textAlign,
      validator: this.widget.validator,
      maxLines: this.widget.maxLines,
      keyboardType: this.widget.keyBoardType,
      decoration: InputDecoration(
        labelText: this.widget.labelText,
        filled: this.widget.filled,
        fillColor: this.widget.fillColor,
        hintText: this.widget.hintText,
        suffixIcon: !this.widget.child
            ? null
            : GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () => setState(() {
                  _obscureText = !_obscureText;
                }),
                child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
