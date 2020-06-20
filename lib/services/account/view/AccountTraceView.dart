import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/account/state/AccountTraceState.dart';
import 'package:flutter/cupertino.dart';

class AccountTrace extends StatefulWidget {
  final User profile;

  AccountTrace({Key key, @required this.profile}) : super(key: key);

  State<AccountTrace> createState() => AccountTraceState();
}
