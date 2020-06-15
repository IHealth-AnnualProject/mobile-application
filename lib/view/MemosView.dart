import 'package:betsbi/state/MemoViewState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosPage extends StatefulWidget {
  final bool isOffline;
  MemosPage({Key key, this.isOffline = false }) : super(key: key);

  @override
  State<MemosPage> createState() => MemosViewState();
}
