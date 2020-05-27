import 'package:betsbi/controller/ExerciseController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/exercise.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/view/ExerciseView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ExerciseListViewState extends State<ExerciseListViewPage>
    with WidgetsBindingObserver {
  List<Widget> list;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
    list = new List<Widget>();
  }

  ListTile exercise({@required String leading, Exercise exercise}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(leading),
      ),
      title: Text(exercise.name),
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseView(exercise),
          ),
          (Route<dynamic> route) => false,
        );
        //_controller.play();
      },
      subtitle: Text(exercise.type),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: FutureBuilder(
          future: ExerciseController.getJsonAccodingToExerciseType(
              context: context, type: this.widget.type),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              decodeJsonAndStoreItInsideExerciseList(snapshot.data.toString());
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: list[index],
                  );
                },
              );
            } else
              return CircularProgressIndicator();
          }),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }

  void decodeJsonAndStoreItInsideExerciseList(String jsonToDecode) {
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Exercise> exercises = new List<Exercise>();
    exercises.addAll(
        listFromJson.map((model) => Exercise.fromJsonToTube(model)).toList());
    exercises.forEach(
      (element) {
        list.add(
          exercise(leading: this.widget.leading, exercise: element),
        );
      },
    );
  }
}
