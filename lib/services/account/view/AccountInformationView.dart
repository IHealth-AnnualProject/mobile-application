import 'package:flutter/cupertino.dart';

import '../state/AccountInformationState.dart';
import '../model/user.dart';

class AccountInformation extends StatefulWidget {
  final bool isReadOnly;
  final bool isPsy;
  final User profile;
  AccountInformation(
      {@required this.isReadOnly, this.isPsy, this.profile, Key key})
      : super(key: key);

  State<AccountInformation> createState() => AccountInformationState();
}
