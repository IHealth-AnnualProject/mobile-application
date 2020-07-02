import 'package:betsbi/services/exercise/model/cardElement.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';

class SimilarCard extends Exercise {
  final List<CardElement> cardList;
  final int numberColumnCardList;

  SimilarCard(
      {@required this.cardList, @required String name,this.numberColumnCardList, @required String type})
      : super(name, type);

  factory SimilarCard.fromJson(Map<String, dynamic> json) {
    var cards = json['CardList'] as List;
    List<CardElement> cardList =
        cards.map((i) => CardElement.fromJson(i)).toList();
    int columnNumber = cardList.length;
    var tempCardList = cardList;
    for(int i = 0; i < columnNumber - 1; i ++)
      cardList += tempCardList;
    cardList.shuffle();
    return SimilarCard(
        name: json['Name'], type: json['Type'], cardList: cardList,numberColumnCardList: columnNumber);
  }
}
