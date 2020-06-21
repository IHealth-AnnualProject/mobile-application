import 'package:betsbi/services/exercise/model/cardElement.dart';
import 'package:betsbi/services/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';

class SimilarCard extends Exercise {
  List<CardElement> cardList;

  SimilarCard(
      {@required this.cardList, @required String name, @required String type})
      : super(name, type);

  factory SimilarCard.fromJson(Map<String, dynamic> json) {
    var cards = json['CardList'] as List;
    List<CardElement> cardList =
        cards.map((i) => CardElement.fromJson(i)).toList();
    cardList += cardList;
    cardList.shuffle();
    return SimilarCard(
        name: json['Name'], type: json['Type'], cardList: cardList);
  }
}
