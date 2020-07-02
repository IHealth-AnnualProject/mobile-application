import 'package:flutter/cupertino.dart';

import '../state/AccountInformationState.dart';
import '../model/user.dart';

class AccountInformationPage extends StatefulWidget {
  final bool isReadOnly;
  final bool isPsy;
  final User profile;
  AccountInformationPage(
      {@required this.isReadOnly, this.isPsy, this.profile, Key key})
      : super(key: key);

  State<AccountInformationPage> createState() => AccountInformationState();
}
