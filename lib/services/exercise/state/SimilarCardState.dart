import 'package:betsbi/services/exercise/view/SimilarCardExerciseView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/AvatarSkinWidget.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SimilarCardState extends State<SimilarCardPage> {
  List<Widget> cardsElement;

  @override
  void initState() {
    cardsElement = new List<Widget>();
    this.widget.exercise.cardList.forEach(
          (card) => cardsElement.add(
            GestureDetector(
              onTap: () => print(card.id),
              child: AvatarSkinWidget(
                skinColor: card.cardColor,
                accessoryImage: card.accessoryPath,
                faceImage: card.facePath,
              ),
            ),
          ),
        );
    super.initState();
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
        body: GridView.builder(
          shrinkWrap: true,
          itemCount: cardsElement.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Card(
                  child: cardsElement[index],
                ),
              ),
            ),
          ),
        ));
  }
}
