import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainingPage extends StatefulWidget {
  TrainingPage({Key key}) : super(key: key);

  @override
  _TrainingView createState() => _TrainingView();
}

class _TrainingView extends State<TrainingPage> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity().then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleTraining = Text(
      SettingsManager.mapLanguage["MyTrainingContainer"],
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.cyan[300], fontSize: 40),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  color: Colors.cyan,
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseListViewPage(
                              leading: "assets/math.png",
                              type: "Math",
                            ),
                          ),
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 40.0,
                              ),
                            ],
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/math.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
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
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 40.0,
                              ),
                            ],
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/muscle.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseListViewPage(
                      leading: "assets/emergency.png",
                      type: "Emergency",
                    ),
                  ),
                ),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 40.0,
                      ),
                    ],
                    color: Colors.cyan,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/emergency.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
