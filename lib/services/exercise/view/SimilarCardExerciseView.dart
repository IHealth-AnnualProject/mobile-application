import 'package:betsbi/services/exercise/model/similarCard.dart';
import 'package:betsbi/services/exercise/state/SimilarCardState.dart';
import 'package:flutter/cupertino.dart';

class SimilarCardPage extends StatefulWidget{

  final SimilarCard exercise;
  final bool isOffline;

  SimilarCardPage({this.exercise, this.isOffline = false});

  @override
  State<SimilarCardPage> createState() => SimilarCardState();
}