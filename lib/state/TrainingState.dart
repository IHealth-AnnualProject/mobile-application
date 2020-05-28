import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/view/TrainingView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TrainingState extends State<TrainingPage> with WidgetsBindingObserver {
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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  Text title({String content}) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 40),
    );
  }

  Text content({String content}) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 17),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleTraining = Text(
      SettingsManager.mapLanguage["MyTrainingContainer"],
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return Scaffold(
      appBar: AppSearchBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 40.0,
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/exercise.png"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleTraining,
            SizedBox(
              height: 45,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListViewPage(
                            type: "Math",
                            leading: "assets/math.png",
                          ),
                        ),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.width + 20,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Color.fromRGBO(0, 157, 153, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(1.0, 6.0),
                                    blurRadius: 40.0,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/math.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            title(
                                content: SettingsManager
                                    .mapLanguage["ExerciseMath"]),
                            SizedBox(
                              height: 20,
                            ),
                            content(
                                content: SettingsManager
                                    .mapLanguage["MathExplanation"]),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListViewPage(
                            leading: "assets/muscle.png",
                            type: "Muscle",
                          ),
                        ),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.width + 20,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Color.fromRGBO(0, 157, 153, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(1.0, 6.0),
                                    blurRadius: 40.0,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/muscle.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            title(
                                content: SettingsManager
                                    .mapLanguage["ExercisePhysical"]),
                            SizedBox(
                              height: 20,
                            ),
                            content(
                                content: SettingsManager
                                    .mapLanguage["TrainingExplanation"]),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListViewPage(
                            type: "Emergency",
                            leading: "assets/emergency.png",
                          ),
                        ),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.width + 20,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Color.fromRGBO(0, 157, 153, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(1.0, 6.0),
                                    blurRadius: 40.0,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/emergency.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            title(
                                content: SettingsManager
                                    .mapLanguage["ExerciseEmergency"]),
                            SizedBox(
                              height: 20,
                            ),
                            content(
                                content: SettingsManager
                                    .mapLanguage["EmergencyExplanation"]),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
