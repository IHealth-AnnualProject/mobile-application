import 'dart:collection';
import 'dart:convert';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
  runApp(Home());
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetsBi',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalConfiguration cfg = new GlobalConfiguration();
  LinkedHashMap<String, dynamic> dmap = new LinkedHashMap<String, dynamic>();
  int _selectedBottomIndex = 0;
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future loadLanguage(String path) async {
    dmap = await parseJsonFromAssets(path);
    setState(() {});
  }

  void _onBottomTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadLanguage(
        'locale/' + cfg.getString('currentLanguage').toLowerCase() + '.json');
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final password = TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: dmap["PasswordText"] != null ? dmap["PasswordText"] : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final gridView = CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["MyAccountContainer"] != null
                            ? dmap["MyAccountContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.play_for_work,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["MyTrainingContainer"] != null
                            ? dmap["MyTrainingContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.wrap_text,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["MyMemosContainer"] != null
                            ? dmap["MyMemosContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["MyAmbianceContainer"] != null
                            ? dmap["MyAmbianceContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.not_listed_location,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["MyQuestContainer"] != null
                            ? dmap["MyQuestContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Container(
                  color: Color.fromRGBO(51, 171, 249, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 150,
                      ),
                      new Text(
                        dmap["ErrorContainer"] != null
                            ? dmap["ErrorContainer"]
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Expanded(
             child: gridView,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
        ],
        currentIndex: _selectedBottomIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onBottomTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
