import 'package:betsbi/services/account/state/AccountState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final bool isPsy;
  final String userId;
  AccountPage({this.isPsy, @required this.userId, Key key})
      : super(key: key);

  @override
  AccountState createState() => AccountState();
}