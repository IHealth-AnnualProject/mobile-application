import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/account/state/AccountTraceState.dart';
import 'package:flutter/cupertino.dart';

class AccountTracePage extends StatefulWidget {
  final User profile;

  AccountTracePage({Key key, @required this.profile}) : super(key: key);

  State<AccountTracePage> createState() => AccountTraceState();
}
