import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/controller/ExerciseController.dart';
import 'package:betsbi/services/exercise/model/cardElement.dart';
import 'package:betsbi/services/exercise/view/SimilarCardExerciseView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SimilarCardState extends State<SimilarCardPage> {
  List<Widget> cardsElement;
  int numberOfCardFlipped = 0;
  int firstCardReturnedIndex;
  int secondCardReturnedIndex;
  int firstCardReturnedIndexFromList;
  List<CardElement> currentCardList;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<GlobalKey<FlipCardState>> cardListKey =
      new List<GlobalKey<FlipCardState>>();

  @override
  void initState() {
    currentCardList = this.widget.exercise.cardList;
    fullCardElementsWithListOfCard();
    super.initState();
  }

  void fullCardElementsWithListOfCard({bool canFlip = true}) {
    cardsElement = new List<Widget>();
    cardListKey = new List<GlobalKey<FlipCardState>>();
    currentCardList.asMap().forEach((index, card) {
      cardKey = GlobalKey<FlipCardState>();
      cardListKey.add(cardKey);
      cardsElement.add(
        GestureDetector(
          child: FlipCard(
            key: cardKey,
            flipOnTouch: canFlip,
            front: Container(
              color: Colors.white,
            ),
            onFlip: () => updateCurrentGridViewIfBothElementHaveEqualsId(
                currentCardId: card.id, currentIndex: index),
            onFlipDone: (done) async {
              if (currentCardList.isEmpty)
                await ExerciseController.showAlertDialog(context: context);
            },
            back: Container(
              width: 150,
              height: 150,
              color: card.cardColor,
              child: Image.asset(
                "assets/skin/accessories/" + card.accessoryPath,
              ),
            ),
          ),
        ),
      );
    });
  }

  void updateCurrentGridViewIfBothElementHaveEqualsId(
      {@required int currentCardId, @required int currentIndex}) {
    numberOfCardFlipped++;
    if (numberOfCardFlipped == 1) {
      firstCardReturnedIndex = currentCardId;
      firstCardReturnedIndexFromList = currentIndex;
    }
    if (numberOfCardFlipped == 2) {
      secondCardReturnedIndex = currentCardId;
      Future.delayed(Duration(seconds: 1)).whenComplete(
        () => setState(
          () {
            numberOfCardFlipped = 0;
            if (secondCardReturnedIndex == firstCardReturnedIndex &&
                currentIndex != firstCardReturnedIndexFromList) {
              if (firstCardReturnedIndexFromList > currentIndex) {
                currentCardList.removeAt(firstCardReturnedIndexFromList);
                currentCardList.removeAt(currentIndex);
              } else {
                currentCardList.removeAt(currentIndex);
                currentCardList.removeAt(firstCardReturnedIndexFromList);
              }
              fullCardElementsWithListOfCard();
            } else
              fullCardElementsWithListOfCard();
            if(currentCardList.isEmpty) ExerciseController.showAlertDialog(context: context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: this.widget.isOffline,
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffline,
        selectedBottomIndexOffLine: null,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              DefaultTextTitle(
                title: SettingsManager.mapLanguage["SimilarCardTitle"],
              ),
              SizedBox(
                height: 45,
              ),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: cardsElement.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: this.widget.exercise.numberColumnCardList),
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  columnCount: this.widget.exercise.numberColumnCardList,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: Card(
                        child: cardsElement[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
